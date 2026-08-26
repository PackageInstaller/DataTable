-- chunkname: @modules/logic/versionactivity2_4/act181/view/Activity181BonusItem.lua

module("modules.logic.versionactivity2_4.act181.view.Activity181BonusItem", package.seeall)

local Activity181BonusItem = class("Activity181BonusItem", LuaCompBase)

Activity181BonusItem.ANI_IDLE = "idle"
Activity181BonusItem.ANI_CAN_GET = "get"
Activity181BonusItem.ANI_COVER_OPEN = "coveropen"

function Activity181BonusItem:init(go)
	self.go = go
	self._imgQuality = gohelper.findChildImage(go, "OptionalItem/#img_Quality")
	self._simgItem = gohelper.findChildSingleImage(go, "OptionalItem/#simage_Item")
	self._goOptionalItem = gohelper.findChild(go, "OptionalItem")
	self._goImageBg = gohelper.findChild(go, "image_BG")
	self._txtNum = gohelper.findChildTextMesh(go, "OptionalItem/image_NumBG/#txt_Num")
	self._txtItemName = gohelper.findChildTextMesh(go, "OptionalItem/#txt_ItemName")
	self._goCover = gohelper.findChild(go, "#go_Cover")
	self._goGet = gohelper.findChild(go, "#go_Get")
	self._goCoverClose = gohelper.findChild(go, "image_Cover")
	self._goCoverOpen = gohelper.findChild(go, "image_CoverOpen")
	self._btnClick = gohelper.findChildButton(go, "click")
	self._goType1 = gohelper.findChild(go, "#go_Cover/#go_Type1")
	self._goType2 = gohelper.findChild(go, "#go_Cover/#go_Type2")
	self._goType3 = gohelper.findChild(go, "#go_Cover/#go_Type3")
	self._goType4 = gohelper.findChild(go, "#go_Cover/#go_Type4")

	self:initItem()
end

function Activity181BonusItem:initItem()
	self._typeList = {
		self._goType1,
		self._goType2,
		self._goType3,
		self._goType4
	}

	self._btnClick:AddClickListener(self.onClickItem, self)

	self._animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)

	gohelper.setActive(self._txtItemName, false)

	self._animator.enabled = true
end

function Activity181BonusItem:onClickItem()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if not Activity181Model.instance:isActivityInTime(self._activityId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local info = Activity181Model.instance:getActivityInfo(self._activityId)

	if info:getBonusState(self._pos) == Activity181Enum.BonusState.HaveGet then
		local bonusConfig = Activity181Config.instance:getBoxListConfig(self._activityId, self._boxId)
		local param = string.splitToNumber(bonusConfig.bonus, "#")

		MaterialTipController.instance:showMaterialInfo(param[1], param[2], false)

		return
	end

	if info.canGetTimes <= 0 then
		GameFacade.showToast(ToastEnum.NorSign)

		return
	end

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	Activity181Controller.instance:getBonus(self._activityId, self._pos)
end

function Activity181BonusItem:setEnable(active)
	gohelper.setActive(self.go, active)
end

function Activity181BonusItem:onUpdateMO(pos, activityId, isOpen)
	self._pos = pos
	self._activityId = activityId

	local activityInfo = Activity181Model.instance:getActivityInfo(activityId)
	local haveGet = activityInfo:getBonusState(pos) == Activity181Enum.BonusState.HaveGet
	local canGet = activityInfo:getBonusTimes() > 0
	local showItem, animName

	if isOpen then
		showItem = true
		animName = self.ANI_COVER_OPEN

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_get)
	else
		showItem = haveGet
		animName = canGet and not haveGet and self.ANI_CAN_GET or self.ANI_IDLE
	end

	gohelper.setActive(self._goImageBg, showItem)
	gohelper.setActive(self._goOptionalItem, showItem)
	gohelper.setActive(self._goCover, not haveGet or isOpen)
	gohelper.setActive(self._goCoverClose, not haveGet)
	gohelper.setActive(self._goCoverOpen, haveGet)
	gohelper.setActive(self._simgItem.gameObject, haveGet)
	self._animator:Play(animName)

	local seed = tonumber(PlayerModel.instance:getMyUserId()) * pos

	math.randomseed(seed)

	local range = #self._typeList
	local randomIndex = math.random(1, range)

	for index, go in ipairs(self._typeList) do
		gohelper.setActive(go, index == randomIndex)
	end

	if not haveGet then
		return
	end

	self._boxId = activityInfo:getBonusIdByPos(pos)

	local config = Activity181Config.instance:getBoxListConfig(self._activityId, self._boxId)
	local param = string.splitToNumber(config.bonus, "#")
	local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(param[1], param[2], true)

	self._txtNum.text = tostring(param[3])

	self._simgItem:LoadImage(icon)
	UISpriteSetMgr.instance:setUiFBSprite(self._imgQuality, "bg_pinjidi_" .. tostring(itemConfig.rare))
end

function Activity181BonusItem:setBonusFxState(haveGet, canGet)
	if not haveGet and canGet then
		if not self.ANI_CAN_GET then
			local animName = self.ANI_IDLE

			gohelper.setActive(self._goCover, not haveGet)
			self._animator:Play(animName)
		end
	end
end

function Activity181BonusItem:onDestroy()
	self._btnClick:RemoveClickListener()

	self._typeList = nil
end

return Activity181BonusItem
