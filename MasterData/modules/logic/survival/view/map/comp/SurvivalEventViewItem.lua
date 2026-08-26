-- chunkname: @modules/logic/survival/view/map/comp/SurvivalEventViewItem.lua

module("modules.logic.survival.view.map.comp.SurvivalEventViewItem", package.seeall)

local SurvivalEventViewItem = class("SurvivalEventViewItem", LuaCompBase)

function SurvivalEventViewItem:init(go)
	self._btnClick = gohelper.findChildButtonWithAudio(go, "")
	self._goselect = gohelper.findChild(go, "Rotate/#go_Selected")
	self._gounselect = gohelper.findChild(go, "Rotate/#go_Mask")
	self._imagehead = gohelper.findChildSingleImage(go, "Rotate/#image_head")
	self._imagecolor = gohelper.findChildImage(go, "Rotate/#image_color")
	self._imageIcon = gohelper.findChildImage(go, "Rotate/#simage_Icon")
end

function SurvivalEventViewItem:addEventListeners()
	self._btnClick:AddClickListener(self._onClick, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEventViewSelectChange, self.onSelectChange, self)
end

function SurvivalEventViewItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEventViewSelectChange, self.onSelectChange, self)
end

local unitTypeToBgName = {
	[SurvivalEnum.UnitType.Search] = "survivalevent_itemiconbg3",
	[SurvivalEnum.UnitType.Task] = "survivalevent_itemiconbg3",
	[SurvivalEnum.UnitType.NPC] = "survivalevent_itemiconbg3",
	[SurvivalEnum.UnitType.Treasure] = "survivalevent_itemiconbg3",
	[SurvivalEnum.UnitType.Battle] = "survivalevent_itemiconbg1",
	[SurvivalEnum.UnitType.Exit] = "survivalevent_itemiconbg2",
	[SurvivalEnum.UnitType.Door] = "survivalevent_itemiconbg2"
}
local unitTypeToIconName = {
	[SurvivalEnum.UnitType.Task] = "survival_map_icon_1",
	[SurvivalEnum.UnitType.NPC] = "survival_map_icon_2",
	[SurvivalEnum.UnitType.Treasure] = "survival_map_icon_5",
	[SurvivalEnum.UnitType.Exit] = "survival_map_icon_8",
	[SurvivalEnum.UnitType.Door] = "survival_map_icon_9"
}

function SurvivalEventViewItem:initData(data, index)
	self.data = data
	self.index = index

	self:onSelectChange(1)

	local unitType = data.unitType

	if data.co then
		if unitType == SurvivalEnum.UnitType.NPC then
			gohelper.setActive(self._imagehead, true)
			gohelper.setActive(self._imagecolor, false)
			gohelper.setActive(self._imageIcon, false)

			local itemCo = SurvivalConfig.instance.npcIdToItemCo[data.cfgId]

			if itemCo then
				self._imagehead:LoadImage(ResUrl.getSurvivalNpcIcon(itemCo.icon))
			end
		else
			gohelper.setActive(self._imagehead, false)
			gohelper.setActive(self._imagecolor, true)
			gohelper.setActive(self._imageIcon, true)
			UISpriteSetMgr.instance:setSurvivalSprite(self._imagecolor, unitTypeToBgName[unitType])

			if unitType == SurvivalEnum.UnitType.Search then
				local isSearched = data:isSearched()

				if isSearched then
					UISpriteSetMgr.instance:setSurvivalSprite(self._imageIcon, "survival_map_icon_4")
				else
					UISpriteSetMgr.instance:setSurvivalSprite(self._imageIcon, "survival_map_icon_3")
				end
			elseif unitType == SurvivalEnum.UnitType.Battle then
				if data.co.type == 41 or data.co.type == 43 then
					UISpriteSetMgr.instance:setSurvivalSprite(self._imageIcon, "survival_map_icon_6")
				else
					UISpriteSetMgr.instance:setSurvivalSprite(self._imageIcon, "survival_map_icon_7")
				end
			elseif data.co == SurvivalEnum.UnitSubType.Shop then
				UISpriteSetMgr.instance:setSurvivalSprite(self._imageIcon, "survival_map_icon_15")
			else
				UISpriteSetMgr.instance:setSurvivalSprite(self._imageIcon, unitTypeToIconName[unitType])
			end
		end
	end
end

function SurvivalEventViewItem:_onClick()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEventViewSelectChange, self.index)
end

function SurvivalEventViewItem:onSelectChange(index)
	gohelper.setActive(self._goselect, index == self.index)
	gohelper.setActive(self._gounselect, index ~= self.index)
end

return SurvivalEventViewItem
