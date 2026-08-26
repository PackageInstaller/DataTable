-- chunkname: @modules/logic/sp01/assassinChase/view/AssassinChaseChatView.lua

module("modules.logic.sp01.assassinChase.view.AssassinChaseChatView", package.seeall)

local AssassinChaseChatView = class("AssassinChaseChatView", BaseView)

function AssassinChaseChatView:onInitView()
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")
	self._gohead = gohelper.findChild(self.viewGO, "#go_head")
	self._goheadgrey = gohelper.findChild(self.viewGO, "#go_head/#go_headgrey")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "#go_head/#simage_head")
	self._goname = gohelper.findChild(self.viewGO, "#go_name")
	self._txtnamecn1 = gohelper.findChildTextMesh(self.viewGO, "#go_name/namelayout/#txt_namecn1")
	self._gocontents = gohelper.findChild(self.viewGO, "#go_contents")
	self._txtcontentcn = gohelper.findChildTextMesh(self.viewGO, "#go_contents/txt_contentcn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinChaseChatView:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function AssassinChaseChatView:removeEvents()
	self._btnClick:RemoveClickListener()
end

function AssassinChaseChatView:_btnClickOnClick()
	self:_checkNextStep()
end

function AssassinChaseChatView:_editableInitView()
	return
end

function AssassinChaseChatView:onUpdateParam()
	return
end

function AssassinChaseChatView:onOpen()
	local viewParam = self.viewParam

	self._dialogIndex = 1
	self._configIndex = 1
	self._actId = viewParam.actId

	local dialogConfigList = AssassinChaseConfig.instance:getDialogueConfigList(viewParam.actId)

	if dialogConfigList == nil then
		logError("奥德赛下半角色活动 对话表为空 actId:" .. tostring(viewParam.actId))
		self:closeThis()

		return
	end

	self._configList = dialogConfigList
	self._configCount = #dialogConfigList

	self:refreshUI()
end

function AssassinChaseChatView:_checkNextStep()
	if self._configIndex >= self._configCount then
		self:closeThis()

		return
	end

	self._configIndex = self._configIndex + 1

	self:refreshUI()
end

function AssassinChaseChatView:refreshUI()
	local configIndex = self._configIndex
	local dialogConfig = self._configList[configIndex]

	self._simagehead:LoadImage(ResUrl.getHeadIconSmall(dialogConfig.roleIcon))

	self._txtnamecn1.text = dialogConfig.roleName
	self._txtcontentcn.text = dialogConfig.dialog
end

function AssassinChaseChatView:onClose()
	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnDialogueEnd)
end

function AssassinChaseChatView:onDestroyView()
	self._simagehead:UnLoadImage()
end

return AssassinChaseChatView
