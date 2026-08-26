-- chunkname: @modules/logic/sp01/assassinChase/view/AssassinChaseOptionItem.lua

module("modules.logic.sp01.assassinChase.view.AssassinChaseOptionItem", package.seeall)

local AssassinChaseOptionItem = class("AssassinChaseOptionItem", LuaCompBase)

function AssassinChaseOptionItem:init(go)
	self.viewGO = go
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#image_Icon")
	self._txtPath = gohelper.findChildText(self.viewGO, "#txt_Path")
	self._txtTargetDescr = gohelper.findChildText(self.viewGO, "#txt_TargetDescr")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._btnClick = gohelper.findChildButton(self.viewGO, "")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinChaseOptionItem:_editableInitView()
	return
end

function AssassinChaseOptionItem:addEventListeners()
	self._btnClick:AddClickListener(self.onBtnClickOnClick, self)
end

function AssassinChaseOptionItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function AssassinChaseOptionItem:onBtnClickOnClick()
	local infoMo = AssassinChaseModel.instance:getCurInfoMo()

	if infoMo:isSelect() and infoMo:canChangeDirection() == false then
		local changeEndStr = TimeUtil.timestampToString4(infoMo.changeEndTime)

		GameFacade.showToast(ToastEnum.AssassinChaseChangeTimeEndTip, {
			changeEndStr
		})

		return
	end

	logNormal("奥德赛 下半活动 点击追逐方向 方向:" .. tostring(self._directionId))
	AssassinChaseModel.instance:setCurDirectionId(self._directionId)
end

function AssassinChaseOptionItem:setData(activityId, id)
	self._actId = activityId
	self._directionId = id

	self:refreshUI()
end

function AssassinChaseOptionItem:refreshUI()
	self:setSelect(nil)

	if self._directionId == nil then
		logError("奥德赛 下半活动 追逐游戏活动 方向id为空")
		self:clear()

		return
	end

	local optionConfig = AssassinChaseConfig.instance:getDirectionConfig(self._actId, self._directionId)

	if optionConfig == nil then
		logError("奥德赛 下半活动 追逐游戏活动 方向id不存在 id:" .. self._directionId)
		self:clear()

		return
	end

	self._txtPath.text = optionConfig.name
	self._txtTargetDescr.text = optionConfig.des

	if string.nilorempty(optionConfig.pic) then
		return
	end

	UISpriteSetMgr.instance:setSp01Act205Sprite(self._imageIcon, optionConfig.pic)
end

function AssassinChaseOptionItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function AssassinChaseOptionItem:clear()
	self._directionId = nil

	self:setActive(false)
	self:setSelect(nil)
end

function AssassinChaseOptionItem:setSelect(selectId)
	gohelper.setActive(self._goSelected, self._directionId and self._directionId == selectId)
end

function AssassinChaseOptionItem:onDestroy()
	return
end

return AssassinChaseOptionItem
