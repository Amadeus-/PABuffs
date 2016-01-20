local addon, shared = ...

local default_settings = {
	ic = 64, mmx=200, mmy=200, locked = false
	}

_PABUFFS = { UI = {} }

local PB = _PABUFFS

local PB_EARTH	=1
local PB_AIR	=2
local PB_FIRE	=3
local PB_WATER	=4
local PB_LIFE	=5
local PB_DEATH	=6
local PB_PVP	=8


-- In order to retain 'tiering' of abilities, we will assign those abilities in the Steam, Dusk, and Dust planes the same plane assignment
-- as the ability it is replacing.  For example, the Steam ability "Serrated Edge" is replacing the Fire ability "Honed Edge".   So, below,
-- we will assign it PB_FIRE, but indicate that it is tier 4.

local PABUFFS_ALL = {
	["A7B814A4C74B851F1"] = {tier=2, plane=PB_EARTH, loc_name="", en_name="Earthen Shards", calling={["cleric"] = true, ["mage"] = false, ["rogue"] = false, ["warrior"] = true}},
	["A033258D88B14468A"] = {tier=3, plane=PB_EARTH, loc_name="", en_name="Earthen Barbs", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = false, ["warrior"] = true}},
	["A43070E3DC752DF5C"] = {tier=2, plane=PB_AIR, loc_name="", en_name="Storm Glyph", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = false, ["warrior"] = true}},
	["A7728DC6B9DB479EC"] = {tier=3, plane=PB_AIR, loc_name="", en_name="Storm Sigil", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = false, ["warrior"] = true}},
	["A7D7D6E5EEE7DE1C8"] = {tier=2, plane=PB_FIRE, loc_name="", en_name="Razor Edge", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = true}},
	["A2F667B08906DEF4C"] = {tier=3, plane=PB_FIRE, loc_name="", en_name="Honed Edge", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = true}},
	["A6A2848A384B02CD8"] = {tier=4, plane=PB_FIRE, loc_name="", en_name="Serrated Edge", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = true}},
	["A0D9A99C043DAC5C9"] = {tier=2, plane=PB_WATER, loc_name="", en_name="Weapon Guard", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = true}},
	["A5E90B289AB629D98"] = {tier=3, plane=PB_WATER, loc_name="", en_name="Weapon Shield", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = true}},
	["A778CD061789A926E"] = {tier=2, plane=PB_LIFE, loc_name="", en_name="Keen Edge", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = false, ["warrior"] = true}},
	["A68F2F2653D74C91E"] = {tier=3, plane=PB_LIFE, loc_name="", en_name="Planar Edge", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = false, ["warrior"] = true}},
	["A1160463397A685FC"] = {tier=2, plane=PB_DEATH, loc_name="", en_name="Vampiric Essence", calling={["cleric"] = true, ["mage"] = true, ["rogue"] = true, ["warrior"] = true}},
	["A39981B75A1663426"] = {tier=2, plane=PB_EARTH, loc_name="", en_name="Barbed Blade", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = false}},
	["A4942DECF5173D951"] = {tier=2, plane=PB_EARTH, loc_name="", en_name="Jagged Blade", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = false}},
	["A47982EFC17E5221D"] = {tier=2, plane=PB_AIR, loc_name="", en_name="Lightning Glyph", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = false}},
	["A0D9451410FBC17E4"] = {tier=3, plane=PB_AIR, loc_name="", en_name="Lightning Sigil", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = false}},
	["A58AB00ECB38C9789"] = {tier=2, plane=PB_LIFE, loc_name="", en_name="Baneful Blade", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = false}},
	["A172874AF9EE9F18E"] = {tier=3, plane=PB_LIFE, loc_name="", en_name="Ruthless Blade", calling={["cleric"] = false, ["mage"] = false, ["rogue"] = true, ["warrior"] = false}},
	["A14FAB44096E395F6"] = {tier=2, plane=PB_EARTH, loc_name="", en_name="Shielding Glyph", calling={["cleric"] = false, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A1834E6A0A95614AE"] = {tier=3, plane=PB_EARTH, loc_name="", en_name="Shielding Sigil", calling={["cleric"] = false, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A4D5E9B6563EEF824"] = {tier=2, plane=PB_AIR, loc_name="", en_name="Thunder Glyph", calling={["cleric"] = false, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A1973CE8A65FEBFE5"] = {tier=3, plane=PB_AIR, loc_name="", en_name="Thunder Sigil", calling={["cleric"] = false, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A286E555986B2DCC8"] = {tier=2, plane=PB_FIRE, loc_name="", en_name="Flaring Glyph", calling={["cleric"] = true, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A518291D2AA7894F8"] = {tier=3, plane=PB_FIRE, loc_name="", en_name="Flaring Sigil", calling={["cleric"] = true, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A464C6E639F333B73"] = {tier=2, plane=PB_WATER, loc_name="", en_name="Icy Glyph", calling={["cleric"] = true, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A6C9E9E6AD8C5BF0D"] = {tier=3, plane=PB_WATER, loc_name="", en_name="Icy Sigil", calling={["cleric"] = true, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A030A909AABE7A215"] = {tier=2, plane=PB_LIFE, loc_name="", en_name="Shimmering Glyph", calling={["cleric"] = true, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A4D27882B648C281B"] = {tier=3, plane=PB_LIFE, loc_name="", en_name="Shimmering Sigil", calling={["cleric"] = true, ["mage"] = true, ["rogue"] = false, ["warrior"] = false}},
	["A0AE09BA2D437AC64"] = {tier=2, plane=PB_AIR, loc_name="", en_name="Wind Glyph", calling={["cleric"] = true, ["mage"] = false, ["rogue"] = false, ["warrior"] = false}},
	["AFAD1DCAF74C84952"] = {tier=3, plane=PB_AIR, loc_name="", en_name="Wind Sigil", calling={["cleric"] = true, ["mage"] = false, ["rogue"] = false, ["warrior"] = false}}
}

local PASPELLS_OTHER = {
	["A38DFCB8220EE4A2D"] = {ix=1, en_name="Ascended Resurrection"},
	["A24FE01816BA3C9E7"] = {ix=2, en_name="Call of the Ascended"},
	["A7E35AC8A40E2C768"] = {ix=3, en_name="Summon Rescue Medic"},
	["A0A65783568220667"] = {ix=3, en_name="Summon Rescue Medic"},
	["A1295A711A040FDC9"] = {ix=4, en_name="Planar Protection"},
	["A407CCC8F795E8575"] = {ix=5, en_name="Planar Surge"},
	["A56BE75923EFAF0FC"] = {ix=5, en_name="Planar Surge"},
	["A1A9C9C7B2B1F15D0"] = {ix=5, en_name="Planar Surge"},
	["A5A199E4B0EB27B26"] = {ix=5, en_name="Planar Surge"},
	["A798550D8AF79AEFC"] = {ix=6, en_name="Sacrifice Life: Planar Charge"},
	["A563D15783DBB2F8B"] = {ix=7, en_name="Omen Sight"},
	["A60203E8E82FC1D26"] = {ix=7, en_name="Quantum Sight"},
}


local PABUFFS_AVL = {
	0,0,0,0,0,0
}

local PASPELLS_AVL = {
	0,0,0,0,0,0,0
}

local curTTability = nil
local pbRefresh = false
local pbScale = false

local function MergeTable(o,n)
	for k,v in pairs(n) do
		if type(v) == "table" then
			if o[k] == nil then
				o[k] = {}
			end
	 	 	if type(o[k]) == 'table' then
	 			MergeTable(o[k], n[k])
	 	 	end
		else
			if o[k] == nil then
				o[k] = v
			end
		end
	end
end

function PB.RefreshBar()
	if Inspect.System.Secure() then
		pbRefresh = true
	else
		pbRefresh = false
		local actvcntt = 0
		local actvcntb = 0
		
		PB.active = false

		local prevFrame = nil
		local prevCFrame = nil
		
		local txtWidth = 0
		
		for x,k in pairs(PABUFFS_AVL) do
			if k ~= 0 then
				if prevFrame == nil then
					PB.UI.popup.f.t[x].f:SetPoint("TOPLEFT", PB.UI.popup.c, "TOPLEFT")
				else
					PB.UI.popup.f.t[x].f:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT")
				end
				if prevCFrame == nil then
					PB.UI.f[x]:SetPoint("TOPLEFT", PB.UI.c_top, "TOPLEFT", 2,2)
				else
					PB.UI.f[x]:SetPoint("TOPLEFT", prevCFrame, "TOPRIGHT", 1,0)
				end
				prevCFrame = PB.UI.f[x]
				prevFrame = PB.UI.popup.f.t[x].f
				
				PB.active = true
				actvcntt = actvcntt + 1
				
				PB.UI.f[x]:SetTexture("Rift", PABUFFS_ALL[k].i)
				PB.UI.popup.f.t[x].i:SetTexture("Rift", PABUFFS_ALL[k].i)
				PB.UI.popup.f.t[x].f:SetVisible(true)
				PB.UI.f[x]:SetVisible(true)
				
				local m = string.format("cast %s", PABUFFS_ALL[k].loc_name)
				PB.UI.popup.f.t[x].t:SetText(PABUFFS_ALL[k].loc_name)
				PB.UI.popup.f.t[x].t:ClearWidth()
				txtWidth = math.max(txtWidth, PB.UI.popup.f.t[x].t:GetWidth())
				PB.UI.f[x].macro = m
				PB.UI.popup.f.t[x].f:EventMacroSet(Event.UI.Input.Mouse.Left.Click, m)
				PB.UI.f[x]:EventMacroSet(Event.UI.Input.Mouse.Left.Click, m)
			else
				PB.UI.f[x]:SetVisible(false)
				PB.UI.popup.f.t[x].f:SetVisible(false)
			end
		end

		prevCFrame = nil
		
		for x,k in pairs(PASPELLS_AVL) do
			if k ~= 0 then
				if prevFrame == nil then
					PB.UI.popup.f.b[x].f:SetPoint("TOPLEFT", PB.UI.popup.c, "TOPLEFT")
				else
					PB.UI.popup.f.b[x].f:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT")
				end
				if prevCFrame == nil then
					PB.UI.p[x]:SetPoint("TOPLEFT", PB.UI.c_bot, "TOPLEFT", 2,2)
				else
					PB.UI.p[x]:SetPoint("TOPLEFT", prevCFrame, "TOPRIGHT", 1,0)
				end
				prevCFrame = PB.UI.p[x]
				prevFrame = PB.UI.popup.f.b[x].f
				
				PB.active = true
				actvcntb = actvcntb + 1
				
				PB.UI.p[x]:SetTexture("Rift", PASPELLS_OTHER[k].i)
				PB.UI.popup.f.b[x].i:SetTexture("Rift", PASPELLS_OTHER[k].i)
				PB.UI.popup.f.b[x].f:SetVisible(true)
				PB.UI.p[x]:SetVisible(true)
				
				local m = string.format("cast %s", PASPELLS_OTHER[k].loc_name)
				PB.UI.popup.f.b[x].t:SetText(PASPELLS_OTHER[k].loc_name)
				PB.UI.popup.f.b[x].t:ClearWidth()
				txtWidth = math.max(txtWidth, PB.UI.popup.f.b[x].t:GetWidth())
				PB.UI.p[x].macro = m
				PB.UI.p[x]:EventMacroSet(Event.UI.Input.Mouse.Left.Click, m)
				PB.UI.popup.f.b[x].f:EventMacroSet(Event.UI.Input.Mouse.Left.Click, m)
			else
				PB.UI.p[x]:SetVisible(false)
				PB.UI.popup.f.b[x].f:SetVisible(false)
			end
		end
		
		for k,v in pairs(PB.UI.popup.f.t) do
			v.f:SetWidth(txtWidth+24)
			v.t:SetWidth(txtWidth)
		end

		for k,v in pairs(PB.UI.popup.f.b) do
			v.f:SetWidth(txtWidth+24)
			v.t:SetWidth(txtWidth)
		end
		
		local toph, topw
		local both, botw
		
		if actvcntt > 0 then
			toph = PABuffs_Settings.ic+3
			topw = (actvcntt * (PABuffs_Settings.ic+1))+3
			PB.UI.c_top:SetWidth(topw)
			PB.UI.c_top:SetHeight(toph)
		else
			toph = 1
			topw = 0
		end
		
		if actvcntb > 0 then
			both = PABuffs_Settings.ic+3
			botw = (actvcntb * (PABuffs_Settings.ic+1))+3
			PB.UI.c_bot:SetWidth(botw)
			PB.UI.c_bot:SetHeight(both)
		else
			both = 1
			botw = 0
		end
		
		PB.popupW = math.max(topw, botw)
		PB.popupH = toph + both
		
		PB.UI.c:SetWidth(PB.popupW)
		PB.UI.c:SetHeight(PB.popupH)
		
		PB.UI.popup.c:SetWidth(24+txtWidth)
		PB.UI.popup.c:SetHeight(24 * (actvcntt + actvcntb))
	end
end

function PB.Event_Ability_New_Remove(h,t)
	for k,v in pairs(t) do
		if PABUFFS_ALL[k] then
			PABUFFS_AVL = {0,0,0,0,0,0}
			break
		end
	end
end

function PB.Event_Ability_New_Add(h,t)
	local barrefresh = false
	for k,v in pairs(t) do
		if PABUFFS_ALL[k] then
			local ad = Inspect.Ability.New.Detail(k)
			PABUFFS_ALL[k].loc_name = ad.name			
			PABUFFS_ALL[k].i = ad.icon
			local c = PABUFFS_ALL[k].plane
			local t = PABUFFS_ALL[k].tier
			local n = PABUFFS_ALL[k].loc_name
			if PABUFFS_AVL[c] == 0 then
				PABUFFS_AVL[c] = k
				barrefresh = true
			else
				local cc = PABUFFS_AVL[c]
				local to = PABUFFS_ALL[cc].tier
				if t > to then
					PABUFFS_AVL[c] = k
					barrefresh = true
				end
			end
		elseif PASPELLS_OTHER[k] then
			local ad = Inspect.Ability.New.Detail(k)
			PASPELLS_OTHER[k].loc_name = ad.name
			PASPELLS_OTHER[k].i = ad.icon
			local c = PASPELLS_OTHER[k].ix
			PASPELLS_AVL[c] = k
			barrefresh = true
		end
	end
	if barrefresh then
		PB.RefreshBar()
	end
end

function PB.CheckMouse()
	local md = Inspect.Mouse()
	local l = PB.UI.popup.c:GetLeft()
	local r = PB.UI.popup.c:GetRight()
	local t = PB.UI.popup.c:GetTop()
	local b = PB.UI.popup.c:GetBottom()
	
	if md.x < l or md.x > r or md.y < t or md.y > b then
		if Inspect.System.Secure() == false then
			PB.UI.popup.c:SetVisible(false)
		end
		Command.Tooltip(nil)
	end
end

function PB.BuildUI()
	PB.UI.ctx = UI.CreateContext(addon.identifier)
	PB.UI.ctx:SetSecureMode("restricted")
	
	PB.UI.mm = UI.CreateFrame("Texture", "PB.UI.mm", PB.UI.ctx)
	PB.UI.mm:SetHeight(36)
	PB.UI.mm:SetWidth(36)

	PB.UI.mm:EventAttach(Event.UI.Input.Mouse.Left.Click, function(self, h)
		if PABuffs_Settings.locked or MINIMAPDOCKER then
			if Inspect.System.Secure() == false then
				PB.UI.popup.c:SetVisible(not PB.UI.popup.c:GetVisible())
			end
		end
	end, "Event.UI.Input.Mouse.Left.Click")

	if MINIMAPDOCKER == nil then
		PB.UI.mm:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
			if PABuffs_Settings.locked == false then
				self.MouseDown = true
				local mouseData = Inspect.Mouse()
				self.sx = mouseData.x - PB.UI.mm:GetLeft()
				self.sy = mouseData.y - PB.UI.mm:GetTop()
			end
		end, "Event.UI.Input.Mouse.Left.Down")

		PB.UI.mm:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
			self.MouseDown = false
			if PABuffs_Settings.locked == false then
				PABuffs_Settings.mmx = PB.UI.mm:GetLeft()
				PABuffs_Settings.mmy = PB.UI.mm:GetTop()
			end
		end, "Event.UI.Input.Mouse.Left.Up")

		PB.UI.mm:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self, h)
			if PABuffs_Settings.locked == false and self.MouseDown then
				local nx, ny
				local mouseData = Inspect.Mouse()
				nx = mouseData.x - self.sx
				ny = mouseData.y - self.sy
				PB.UI.mm:SetPoint("TOPLEFT", UIParent, "TOPLEFT", nx,ny)
			end
		end, "Event.UI.Input.Mouse.Cursor.Move")
		
		PB.UI.mm:EventAttach(Event.UI.Input.Mouse.Right.Click, function(self, h)
			self.MouseDown = false
			PABuffs_Settings.locked = not PABuffs_Settings.locked
			if PABuffs_Settings.locked then
				PB.UI.mm:SetTexture(addon.identifier, "img/mm_locked.png")
			else
				PB.UI.mm:SetTexture(addon.identifier, "img/mm_unlocked.png")
			end
		end, "Event.UI.Input.Mouse.Right.Click")
	end

	PB.UI.c = UI.CreateFrame("Frame", "PB_Container", PB.UI.ctx)
	PB.UI.c:SetSecureMode("restricted")
	PB.UI.c:SetVisible(false)
	PB.UI.c:SetBackgroundColor(0,0,0,0.25)
	PB.UI.c_top = UI.CreateFrame("Frame", "PB_Container1", PB.UI.c)
	PB.UI.c_bot = UI.CreateFrame("Frame", "PB_Container2", PB.UI.c)
	PB.UI.c_top:SetPoint("TOPCENTER", PB.UI.c, "TOPCENTER")
	PB.UI.c_bot:SetPoint("BOTTOMCENTER", PB.UI.c, "BOTTOMCENTER")
	PB.UI.c_top:SetSecureMode("restricted")
	PB.UI.c_bot:SetSecureMode("restricted")

	PB.UI.c:EventAttach(Event.UI.Input.Mouse.Wheel.Forward, function(self, h)
		if Inspect.System.Secure() == false then
			if PABuffs_Settings.ic < 128 then
				PABuffs_Settings.ic = PABuffs_Settings.ic+1
				PB.Rescale()
			end
		end
	end, "Event.UI.Input.Mouse.Wheel.Forward")
	
	PB.UI.c:EventAttach(Event.UI.Input.Mouse.Wheel.Back, function(self, h)
		if Inspect.System.Secure() == false then
			if PABuffs_Settings.ic > 8 then
				PABuffs_Settings.ic = PABuffs_Settings.ic-1
				PB.Rescale()
			end
		end	
	end, "Event.UI.Input.Mouse.Wheel.Back")
	
	PB.UI.popup = { f={ t={}, b={} } }	
	
	PB.UI.popup.c = UI.CreateFrame("Frame", "PB.UI.popup.c", PB.UI.ctx)
	PB.UI.popup.c:SetPoint("TOPLEFT", PB.UI.mm, "BOTTOMLEFT", 0,0)
	PB.UI.popup.c:SetVisible(false)
	PB.UI.popup.c:SetSecureMode("restricted")
	PB.UI.popup.c:SetLayer(1)
	
	PB.UI.f = {}
	PB.UI.p = {}	

	for k,v in pairs(PABUFFS_ALL) do
		local x = v.plane
		if PB.UI.f[x] == nil then
			-- create MM button frames
			local f = UI.CreateFrame("Frame", "popupft#"..x, PB.UI.popup.c)
			f:SetVisible(false)
			f:SetSecureMode("restricted")
			f:SetLayer(2)
			f:SetBackgroundColor(0,0,0,0.5)
			f:SetHeight(24)
			f:EventAttach(Event.UI.Input.Mouse.Cursor.In, function(self, h)
				local ccr = PABUFFS_ALL[k].ccr or 0
				if (ccr <= 0) then
					f:SetBackgroundColor(0,1,0,0.5)
				end 
				Command.Tooltip(k)
			end, "Event.UI.Input.Mouse.Cursor.In")
			f:EventAttach(Event.UI.Input.Mouse.Cursor.Out, function(self, h)
				local ccr = PABUFFS_ALL[k].ccr or 0
				if (ccr <= 0) then
					f:SetBackgroundColor(0,0,0,0.5)
				end
				PB.CheckMouse()
			end, "Event.UI.Input.Mouse.Cursor.Out")
			local i = UI.CreateFrame("Texture", "popupit#"..x, f)
			i:SetLayer(3)
			i:SetPoint("TOPLEFT", f, "TOPLEFT")
			i:SetWidth(24)
			i:SetHeight(24)
			local t = UI.CreateFrame("Text", "popuptt#"..x, f)
			t:SetLayer(3)
			t:SetPoint("TOPLEFT", i, "TOPRIGHT")
			t:SetFontSize(16)
			t:SetFontColor(1,1,1)
			PB.UI.popup.f.t[x] = {f=f, i=i, t=t, m=nil}
			
			local b = UI.CreateFrame("Texture", "PB_Button#"..x, PB.UI.c_top)
			b:SetSecureMode("restricted")
			b:SetWidth(64)
			b:SetHeight(64)
			b:SetAlpha(0.6)
			b:EventAttach(Event.UI.Input.Mouse.Cursor.In, function(self, h)
				curTTability = x
				PB.UI.f[x]:SetAlpha(1)
				Command.Tooltip(PABUFFS_AVL[x])
			end, "Event.UI.Input.Mouse.Cursor.In")
			b:EventAttach(Event.UI.Input.Mouse.Cursor.Out, function(self, h)
				PB.UI.f[x]:SetAlpha(0.6)
				if x == curTTability then
					curTTability = nil
					Command.Tooltip(nil)
				end
			end, "Event.UI.Input.Mouse.Cursor.Out")
			PB.UI.f[x] = b
		end
	end

	for k,v in pairs(PASPELLS_OTHER) do
		local x = v.ix
		if PB.UI.p[x] == nil then
			local f = UI.CreateFrame("Frame", "popupfb#"..x, PB.UI.popup.c)
			f:SetVisible(false)
			f:SetSecureMode("restricted")
			f:SetLayer(2)
			f:SetBackgroundColor(0,0,0,0.5)
			f:SetHeight(24)
			f:EventAttach(Event.UI.Input.Mouse.Cursor.In, function(self, h)
				local ccr = PASPELLS_OTHER[k].ccr or 0
				if (ccr <= 0) then
					f:SetBackgroundColor(0,1,0,0.5)
				end
				Command.Tooltip(k)				
			end, "Event.UI.Input.Mouse.Cursor.In")
			f:EventAttach(Event.UI.Input.Mouse.Cursor.Out, function(self, h)
				local ccr = PASPELLS_OTHER[k].ccr or 0
				if (ccr <= 0) then
					f:SetBackgroundColor(0,0,0,0.5)
				end
				PB.CheckMouse()
			end, "Event.UI.Input.Mouse.Cursor.Out")			
			local i = UI.CreateFrame("Texture", "popupib#"..x, f)
			i:SetLayer(3)
			i:SetPoint("TOPLEFT", f, "TOPLEFT")
			i:SetWidth(24)
			i:SetHeight(24)
			local t = UI.CreateFrame("Text", "popuptb#"..x, f)
			t:SetLayer(3)
			t:SetPoint("TOPLEFT", i, "TOPRIGHT")
			t:SetFontSize(16)
			t:SetFontColor(1,1,1)
			PB.UI.popup.f.b[x] = {f=f, i=i, t=t, m=nil}
			
			local b = UI.CreateFrame("Texture", "PB_Button#"..x, PB.UI.c_bot)
			b:SetSecureMode("restricted")
			b:SetWidth(64)
			b:SetHeight(64)
			b:SetAlpha(0.6)
			b:EventAttach(Event.UI.Input.Mouse.Cursor.In, function(self, h)
				curTTability = x+10
				PB.UI.p[x]:SetAlpha(1)
				Command.Tooltip(PASPELLS_AVL[x])
			end, "Event.UI.Input.Mouse.Cursor.In")
			b:EventAttach(Event.UI.Input.Mouse.Cursor.Out, function(self, h)
				PB.UI.p[x]:SetAlpha(0.6)
				if x+10 == curTTability then
					curTTability = nil
					Command.Tooltip(nil)
				end
			end, "Event.UI.Input.Mouse.Cursor.Out")
			PB.UI.p[x] = b
		end
	end
end

function PB.Command_Slash_Register(h, args)
	local r = {}
	local numargs = 0
	for token in string.gmatch(args, "[^%s]+") do
		numargs=numargs+1
		r[numargs] = token
	end

	if numargs > 0 then
		if r[1] == "toggle" then	
			if PB.active then
				if Inspect.System.Secure() == false then
					if PB.UI.c:GetVisible() then
						PB.UI.c:SetVisible(false)
						if curTTability then
							Command.Tooltip(nil)
						end
						curTTability = nil
					else
						local sx = UIParent:GetWidth()
						local sy = UIParent:GetHeight()
						local md = Inspect.Mouse()
						local popx = 0
						local popy = 0
						if md.x < (PB.popupW/2) then
							popx = 0
						elseif md.x > (sx - (PB.popupW/2)) then
							popx = sx - PB.popupW
						else
							popx = md.x - (PB.popupW/2)
						end
						
						if md.y < (PB.popupH/2) then
							popy = 0
						elseif md.y > (sy-(PB.popupH/2)) then
							popy = sy-PB.popupH
						else
							popy = md.y - (PB.popupH/2)
						end
						
						PB.UI.c:SetPoint("TOPLEFT", UIParent, "TOPLEFT", popx, popy)
						PB.UI.c:SetVisible(true)
					end
				end
			else
				print("No PA Buffs available!")
			end
		elseif r[1] == "check" then
			local s = ""
			local f = false
			local pabuff_name = {}
			for k,v in pairs(PABUFFS_ALL) do
				pabuff_name[v.en_name] = k
			end
			for k,v in pairs(Inspect.Ability.New.Detail(Inspect.Ability.New.List())) do
				if pabuff_name[v.name] then
					if PABUFFS_ALL[k] == nil then
						print(string.format("%s : ID = %s. NOT FOUND.", v.name, k))
						s = s..string.format("[%s : ID = %s. NOT FOUND.]", v.name, k)
						f=true
					end
				end
			end
			if f then
				error(s)
			end
		elseif r[1] == "size" then
			local sz = tonumber(r[2])
			if sz ~= nil then
				sz = math.floor(sz)
				if sz >= 8 and sz <= 128 then
					PABuffs_Settings.ic = sz
					PB.Rescale()
				else
					print("Range for size: 8 .. 128")
				end
			else
				print(sz.." is not a valid size. 8 .. 128")
			end
		end
	end
end

function PB.Event_System_Secure_Enter(h)
	if PB.UI.c:GetVisible() then
		PB.UI.c:SetVisible(false)
		PB.UI.popup.c:SetVisible(false)
		if curTTability then
			Command.Tooltip(nil)
		end
		curTTability = nil
	end
end

function PB.Event_System_Secure_Leave(h)
	if pbRefresh then
		PB.RefreshBar()
	end
	if pbScale then
		PB.Rescale()
	end
end

function PB.Rescale()
	if Inspect.System.Secure() == false then
		for x=1,6 do
			PB.UI.f[x]:SetWidth(PABuffs_Settings.ic)
			PB.UI.f[x]:SetHeight(PABuffs_Settings.ic)
		end
		for x=1,7 do
			PB.UI.p[x]:SetWidth(PABuffs_Settings.ic)
			PB.UI.p[x]:SetHeight(PABuffs_Settings.ic)
		end
		PB.RefreshBar()
		pbScale = false
	else
		pbScale = true
	end
end

function PB.Event_Addon_SavedVariables_Load_End(h,a)
	if a == addon.identifier then
		if PABuffs_Settings == nil then
			PABuffs_Settings = {}
		end
		MergeTable(PABuffs_Settings, default_settings)
		PB.Rescale()
		if MINIMAPDOCKER then
			PB.UI.mm:SetTexture(addon.identifier, "img/mm_locked.png")
			MINIMAPDOCKER.Register(addon.identifier, PB.UI.mm)
		else
			if PABuffs_Settings.locked then
				PB.UI.mm:SetTexture(addon.identifier, "img/mm_locked.png")
			else
				PB.UI.mm:SetTexture(addon.identifier, "img/mm_unlocked.png")
			end
			PB.UI.mm:SetPoint("TOPLEFT", UIParent, "TOPLEFT", PABuffs_Settings.mmx, PABuffs_Settings.mmy)
		end
	end
end

PB.BuildUI()

Command.Event.Attach(Event.Ability.New.Add, PB.Event_Ability_New_Add, "Event.Ability.New.Add")
Command.Event.Attach(Event.Ability.New.Remove, PB.Event_Ability_New_Remove, "Event.Ability.New.Remove")
Command.Event.Attach(Command.Slash.Register("pab"), PB.Command_Slash_Register, "Command.Slash.Register")
Command.Event.Attach(Event.System.Secure.Enter, PB.Event_System_Secure_Enter, "Event.System.Secure.Enter")
Command.Event.Attach(Event.System.Secure.Leave, PB.Event_System_Secure_Leave, "Event.System.Secure.Leave")
Command.Event.Attach(Event.Addon.SavedVariables.Load.End, PB.Event_Addon_SavedVariables_Load_End, "Event.Addon.SavedVariables.Load.End")

print(string.format("v%s loaded.", addon.toc.Version))
