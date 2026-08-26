-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErEquipItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEquipItem", package.seeall)

local MoLiDeErEquipItem = class("MoLiDeErEquipItem", LuaCompBase)

function MoLiDeErEquipItem:init(go)
	self.viewGO = go
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "#txt_Num")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Detail")
	self._goUseFx = gohelper.findChild(self.viewGO, "#use")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErEquipItem:_editableInitView()
	self._imageProp = gohelper.findChildImage(self.viewGO, "#simage_Prop")
end

function MoLiDeErEquipItem:addEventListeners()
	self._btnDetail:AddClickListener(self.onDetailClick, self)
end

function MoLiDeErEquipItem:removeEventListeners()
	self._btnDetail:RemoveClickListener()
end

function MoLiDeErEquipItem:onDetailClick()
	local itemId = self.itemId

	if itemId == MoLiDeErGameModel.instance:getSelectItemId() then
		return
	end

	MoLiDeErGameModel.instance:setSelectItemId(itemId)
end

function MoLiDeErEquipItem:setData(itemId)
	self.itemId = itemId

	self:refreshUI()
end

function MoLiDeErEquipItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function MoLiDeErEquipItem:reset()
	self.itemId = nil

	self:setActive(false)
end

function MoLiDeErEquipItem:setUseFxState(active)
	gohelper.setActive(self._goUseFx, active)
end

function MoLiDeErEquipItem:refreshUI()
	local gameInfo = MoLiDeErGameModel.instance:getCurGameInfo()
	local itemId = self.itemId
	local info = gameInfo:getEquipInfo(itemId)
	local itemConfig = MoLiDeErConfig.instance:getItemConfig(itemId)

	if info == nil or itemConfig == nil then
		logError("莫莉德尔 角色活动 不存在的道具id" .. itemId)

		return
	end

	self._itemConfig = itemConfig
	self._txtNum.text = tostring(info.quantity)

	if not string.nilorempty(itemConfig.picture) then
		self._simageProp:LoadImage(itemConfig.picture)
	end

	local iconColor

	UIColorHelper.set(self._imageProp, info.quantity <= 0 and MoLiDeErEnum.EventBgColor.Dispatching or MoLiDeErEnum.EventBgColor.Normal)
end

function MoLiDeErEquipItem:onDestroy()
	return
end

return MoLiDeErEquipItem
