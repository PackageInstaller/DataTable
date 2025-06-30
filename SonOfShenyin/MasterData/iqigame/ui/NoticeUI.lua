-- chunkname: @IQIGame\\UI\\NoticeUI.lua

local NoticeUI = Base:Extend("NoticeUI", "IQIGame.Onigao.UI.NoticeUI", {})
local NoticeOutsideView = require("IQIGame.UI.Notice.NoticeOutsideView")
local NoticeInsideView = require("IQIGame.UI.Notice.NoticeInsideView")
local NoticeSDKView = require("IQIGame.UI.Notice.NoticeSDKView")

function NoticeUI:OnInit()
	self.noticeOutsideView = NoticeOutsideView.__New(self.Panel1, self, self.UIController)

	self.noticeOutsideView:Close()

	self.noticeInsideView = NoticeInsideView.__New(self.Panel2, self, self.UIController)

	self.noticeInsideView:Close()

	self.noticeSDKView = NoticeSDKView.New(self.SDKNoticePanel, self.UIController)

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateNoticesResult(notices)
		self:RefreshNoticeData(notices)
	end
end

function NoticeUI:GetPreloadAssetPaths()
	return nil
end

function NoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function NoticeUI:OnOpen(userData)
	self.type = userData[1]

	GameNoticeModule.GetNotice(self.type)
end

function NoticeUI:OnClose(userData)
	self:CloseNoticeView()
end

function NoticeUI:CloseNoticeView()
	self.noticeInsideView:Close()
	self.noticeOutsideView:Close()
end

function NoticeUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.GetNoticeResultEvent, self.delegateNoticesResult)
end

function NoticeUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.GetNoticeResultEvent, self.delegateNoticesResult)
end

function NoticeUI:OnPause()
	return
end

function NoticeUI:OnResume()
	return
end

function NoticeUI:OnCover()
	return
end

function NoticeUI:OnReveal()
	return
end

function NoticeUI:OnRefocus(userData)
	return
end

function NoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function NoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function NoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function NoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function NoticeUI:RefreshNoticeData(notices)
	self.noticeSDKView:Show()
	self.noticeSDKView:SetData(notices)
end

function NoticeUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.NoticeUI)
end

function NoticeUI:OnDestroy()
	self.noticeInsideView:Dispose()
	self.noticeOutsideView:Dispose()
	self.noticeSDKView:Dispose()
end

return NoticeUI
