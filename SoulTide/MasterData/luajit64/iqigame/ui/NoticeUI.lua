-- chunkname: @IQIGame\\UI\\NoticeUI.lua

local NoticeUI = Base:Extend("NoticeUI", "IQIGame.Onigao.UI.NoticeUI", {})
local NoticeOutsideView = require("IQIGame.UI.Notice.NoticeOutsideView")
local NoticeInsideView = require("IQIGame.UI.Notice.NoticeInsideView")

function NoticeUI:OnInit()
	self.noticeOutsideView = NoticeOutsideView.__New(self.Panel1, self)

	self.noticeOutsideView:Close()

	self.noticeInsideView = NoticeInsideView.__New(self.Panel2, self)

	self.noticeInsideView:Close()

	function self.delegateBtnClose()
		self:OnBtnClose()
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

	local jumpId = userData[2]

	if self.type == 1 then
		self.noticeOutsideView:Open(userData[2])
	else
		self.noticeInsideView:Open(jumpId)
	end
end

function NoticeUI:OnClose(userData)
	self.noticeInsideView:Close()
	self.noticeOutsideView:Close()
end

function NoticeUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function NoticeUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
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

function NoticeUI:OnDestroy()
	self.noticeInsideView:Dispose()
	self.noticeOutsideView:Dispose()
end

function NoticeUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.NoticeUI)
end

return NoticeUI
