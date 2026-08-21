-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemInfoPart.lua

local ResPetGem = require("ClientData/ResPetGem")
local ResPetGemAttrLibrary = require("ClientData/ResPetGemAttrLibrary")
local ResColor = require("ClientData/ResColor")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "PetGemInfoPart"
local PetGemInfoPart = Class(strClassName, UIControls.Panel)
local SUBATTR_COLOR = {
	nil,
	nil,
	"PETGEM01",
	"PETGEM02",
	"PETGEM03"
}

function PetGemInfoPart:ctor()
	self:initUI()
end

function PetGemInfoPart:initUI()
	self.attrMainPanel = {}

	for i = 1, 2 do
		local attrMain = UIControls.Panel(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i)
		local icon

		if UIControls.checkControlFunc(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/Icon") then
			icon = UIControls.Image(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/Icon")
		end

		local textTitle = UIControls.Label(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/TextTitle")
		local textNum = UIControls.Label(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/TextNum")
		local arrow

		if UIControls.checkControlFunc(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/Arrow") then
			arrow = UIControls.Label(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/Arrow")
		end

		local textNum2 = UIControls.Label(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/TextNum2")
		local efx

		if UIControls.checkControlFunc(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/Efx") then
			efx = UIControls.LazyEffectPlayer(self, self.mPath .. "/AttrMainPanel/AttrMain0" .. i .. "/Efx")
		end

		table.insert(self.attrMainPanel, {
			attrMain = attrMain,
			icon = icon,
			textTitle = textTitle,
			textNum = textNum,
			textNum2 = textNum2,
			arrow = arrow,
			efx = efx
		})
	end

	self.attrSubPanel = {}

	for i = 1, 4 do
		local attr = UIControls.Panel(self, self.mPath .. "/Attr0" .. i)
		local textTitle = UIControls.Label(self, self.mPath .. "/Attr0" .. i .. "/TextTitle")
		local iconNew

		if UIControls.checkControlFunc(self, self.mPath .. "/Attr0" .. i .. "/IconNew") then
			iconNew = UIControls.Panel(self, self.mPath .. "/Attr0" .. i .. "/IconNew")
		end

		local efx

		if UIControls.checkControlFunc(self, self.mPath .. "/Attr0" .. i .. "/Efx") then
			efx = UIControls.LazyEffectPlayer(self, self.mPath .. "/Attr0" .. i .. "/Efx")
		end

		table.insert(self.attrSubPanel, {
			attr = attr,
			textTitle = textTitle,
			iconNew = iconNew,
			efx = efx
		})
	end
end

function PetGemInfoPart:setData(gem, config)
	self.gem = gem
	self.config = config or {}
	self.gemMainAttr = self.gem:getMainAttr()
	self.gemSubAttr = self.gem:getSubAttr()

	local upGemId = ResPetGem[self.gem.id].up_id

	for i, v in ipairs(self.attrMainPanel) do
		local attrInfo = ResPetGemAttrLibrary[self.gemMainAttr.attr_id]

		if attrInfo then
			if attrInfo.attr[i] then
				v.attrMain:setVisible(true)

				local attrName = BattleConst.PROP_TYPE_CONFIG[attrInfo.attr[i].type_id]

				if v.icon then
					local attriconInfo = ClientUtils.getRolePropIcon(attrName)

					v.icon:setImage(attriconInfo[1], attriconInfo[2])
					v.icon:setVisible(true)
				end

				local zhName, value = ClientUtils.getRolePropZhName(attrName, attrInfo.attr[i].num)

				v.textTitle:setText(zhName)
				v.textNum:setText(value)
				v.textNum2:setVisible(false)

				if v.arrow then
					v.arrow:setVisible(false)
				end

				if self.config.showRandMain then
					if v.icon then
						v.icon:setVisible(false)
					end

					v.textTitle:setText(Lang.get(78295))
					v.textNum:setText("???")
				elseif self.config.showLvUpMain and upGemId then
					local randMainLibrary = ResPetGem[upGemId].main_attr_library
					local upValue = attrInfo.attr[i].num

					for _, data in pairs(ResPetGemAttrLibrary) do
						if data.library_id == randMainLibrary then
							for _, attr in pairs(data.attr) do
								if attr.type_id == attrInfo.attr[i].type_id then
									upValue = attr.num
								end
							end
						end
					end

					local zhName, afterValue = ClientUtils.getRolePropZhName(attrName, upValue)

					v.textNum2:setVisible(true)
					v.textNum2:setText(afterValue)

					if v.arrow then
						v.arrow:setVisible(true)
					end
				end
			else
				v.attrMain:setVisible(false)
			end
		end
	end

	self.showRandSub = false

	for i, v in ipairs(self.attrSubPanel) do
		if self.gemSubAttr[i] then
			v.attr:setVisible(true)

			local attrId = self.gemSubAttr[i].attr_id
			local attrInfo = ResPetGemAttrLibrary[attrId]

			if self.config.showRandSub then
				local attrType = attrInfo.attr_type

				for i, v in pairs(ResPetGemAttrLibrary) do
					if ResPetGem[upGemId].vice_attr_library == v.library_id and v.attr_type == attrType then
						attrInfo = v
					end
				end
			end

			if attrInfo then
				v.textTitle:setText(attrInfo.desc)

				local color = ResColor[SUBATTR_COLOR[attrInfo.quality]]

				v.textTitle:setFontColor(color)

				if v.iconNew then
					if self.config.showNewSub and self.gemSubAttr[i + 1] == nil then
						v.iconNew:setVisible(true)
					else
						v.iconNew:setVisible(false)
					end
				end
			end
		elseif self.config.showRandSub and not self.showRandSub then
			if upGemId and ResPetGem[upGemId] then
				local curSubNum = ResPetGem[self.gem.id].vice_attr_num
				local upSubNum = ResPetGem[upGemId].vice_attr_num

				if curSubNum < upSubNum then
					v.attr:setVisible(true)
					v.textTitle:setText(Lang.get(78296))
					v.textTitle:setFontColor(ResColor.COLORRANK05)

					if v.iconNew then
						v.iconNew:setVisible(true)
					end
				else
					v.attr:setVisible(false)
				end

				self.showRandSub = true
			end
		else
			v.attr:setVisible(false)
		end
	end
end

function PetGemInfoPart:playAttrEfx(type, idx)
	local panelList

	if type == Const.PET_GEM_RERAND_ATTR_TYPE_MAIN then
		panelList = self.attrMainPanel
	else
		panelList = self.attrSubPanel
	end

	if idx and idx <= #panelList then
		local efx = panelList[idx].efx

		if efx then
			efx:playEffect()
		end
	end
end

return PetGemInfoPart
