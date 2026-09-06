-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/FullwincomponentView.lua

module("logic.extensions.common.view.FullwincomponentView", package.seeall)

local FullwincomponentView = class("FullwincomponentView", ViewComponent)

function FullwincomponentView:ctor()
	FullwincomponentView.super.ctor(self)
end

function FullwincomponentView:buildUI()
	FullwincomponentView.super.buildUI(self)

	self.closeBtn = self:getBtn("closeBtn")
	self.tipBtn = self:getBtn("tipBtn")
	self.tipBtnTr = self.tipBtn.gameObject.transform
	self.titleText = goutil.findChildTextComponent(self.mainGO, "text")
	self.titleTextTr = self.titleText.gameObject.transform
end

function FullwincomponentView:bindEvents()
	FullwincomponentView.super.bindEvents(self)
end

function FullwincomponentView:unbindEvents()
	FullwincomponentView.super.unbindEvents(self)
end

function FullwincomponentView:destroyUI()
	FullwincomponentView.super.destroyUI(self)
end

function FullwincomponentView:onEnter()
	FullwincomponentView.super.onEnter(self)

	local param = self:getOpenParam()

	self.refTarget = param[1]
	self.title = param[2]
	self.tipClickCallBack = param[3]

	self.closeBtn:AddClickListener(self.onClickClose, self)
	self.tipBtn:AddClickListener(self.onClickTip, self)
	self:initView()
end

function FullwincomponentView:onEnterFinished()
	FullwincomponentView.super.onEnterFinished(self)
end

function FullwincomponentView:onExit()
	FullwincomponentView.super.onExit(self)
	self.mainGO.transform:SetParent(nil)
	self.closeBtn:RemoveClickListener()
	self.tipBtn:RemoveClickListener()
end

function FullwincomponentView:onExitFinished()
	FullwincomponentView.super.onExitFinished(self)
end

function FullwincomponentView:initView()
	GameUtil.SetActive(self.tipBtn, self.tipClickCallBack)
	self:setTitle(self.title)
end

function FullwincomponentView:onClickClose()
	if self.refTarget and self.refTarget.close then
		self.refTarget:close()
	else
		printInfo("没有close函数")
	end
end

function FullwincomponentView:onClickTip()
	if self.tipClickCallBack then
		self.tipClickCallBack()
	end
end

function FullwincomponentView:setTitle(title)
	self.titleText.text = title or ""

	local posX = self.titleTextTr.localPosition.x + self.titleText.preferredWidth + 10

	GameUtil.setLocalPos(self.tipBtn.gameObject, posX, self.tipBtnTr.localPosition.y, 0)
end

return FullwincomponentView
