-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionmallPreviewView.lua

module("logic.extensions.companionmall.view.CompanionmallPreviewView", package.seeall)

local CompanionmallPreviewView = class("CompanionmallPreviewView", ViewComponent)

function CompanionmallPreviewView:ctor()
	CompanionmallPreviewView.super.ctor(self)
end

function CompanionmallPreviewView:unbindEvents()
	CompanionmallPreviewView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function CompanionmallPreviewView:bindEvents()
	CompanionmallPreviewView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickBtnChange, self, -1), self)
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickBtnChange, self, 1), self)
end

function CompanionmallPreviewView:buildUI()
	CompanionmallPreviewView.super.buildUI(self)

	self._imgPreview = self:getGo("imgPreview")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._txtName = self:getTxt("txtName")
end

function CompanionmallPreviewView:onExit()
	CompanionmallPreviewView.super.onExit(self)
	uGuiUtil.clearImage(self._imgPreview.gameObject)
end

function CompanionmallPreviewView:onEnter()
	CompanionmallPreviewView.super.onEnter(self)

	local activityId = checknumber(self:getFirstParam())

	self._activityId = activityId == 0 and CompanionMallController.instance:getDefaultActId() or activityId
	self._showIdx = 1
	self._previewCfgs = CompanionMallConfig.instance:getPreviewCfg(self._activityId)
	self._previewCfg = self._previewCfgs[self._showIdx]
	self._previewNum = #self._previewCfgs

	self:_onUpdate()
end

function CompanionmallPreviewView:_onClickBtnChange(offset)
	local isFirst = self._showIdx == 1
	local isLast = self._showIdx == self._previewNum

	if (offset ~= -1 or not isFirst) and (offset ~= 1 or not isLast) then
		self._showIdx = self._showIdx + offset
	end

	self:_onUpdate()
end

function CompanionmallPreviewView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function CompanionmallPreviewView:_updateData()
	self._previewCfg = self._previewCfgs[self._showIdx]
end

function CompanionmallPreviewView:_updateUI()
	self._txtName.text = self._previewCfg.desc

	uGuiUtil.clearImage(self._imgPreview.gameObject)
	uGuiUtil.setSpriteToImage(self._imgPreview.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/views/huodong/zhoubianshangcheng/%s.png", self._previewCfg.path))
	GameUtil.SetActive(self._btnLeft, self._showIdx ~= 1)
	GameUtil.SetActive(self._btnRight, self._showIdx ~= self._previewNum)
end

return CompanionmallPreviewView
