-- chunkname: @modules/logic/optionpackage/view/OptionPackageDownloadView.lua

local gohelper = require("framework.helper.gohelper")

module("modules.logic.optionpackage.view.OptionPackageDownloadView", package.seeall)

local OptionPackageDownloadView = class("OptionPackageDownloadView", BaseView)

function OptionPackageDownloadView:onInitView()
	self._txtpercent = gohelper.findChildText(self.viewGO, "view/progress/#txt_percent")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "view/progress/loadingline/#img_progress")
	self._goprogress = gohelper.findChild(self.viewGO, "view/progress")
	self._gomessgeBox = gohelper.findChild(self.viewGO, "view/#go_messgeBox")
	self._txtdesc = gohelper.findChildText(self.viewGO, "view/#go_messgeBox/#txt_desc")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_messgeBox/#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_messgeBox/#btn_no")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OptionPackageDownloadView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
end

function OptionPackageDownloadView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
end

function OptionPackageDownloadView:_btnyesOnClick()
	self:_closeInvokeCallback(true)
end

function OptionPackageDownloadView:_btnnoOnClick()
	self:_closeInvokeCallback(false)
end

function OptionPackageDownloadView:_editableInitView()
	self._goNo = self._btnno.gameObject
	self._goYes = self._btnyes.gameObject
	self._txtYes = gohelper.findChildText(self._goYes, "#txt_confirm")
	self._txtNo = gohelper.findChildText(self._goNo, "#txt_cancel")
	self._txtYesen = gohelper.findChildText(self._goYes, "#txt_seitchen")
	self._txtNoen = gohelper.findChildText(self._goNo, "#txt_cancelen")

	self:_showMessgeBoxGo(false)
end

function OptionPackageDownloadView:onOpen()
	self.addEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownloadProgressRefresh, self._onDownloadProgress, self)
	self.addEventCb(self, OptionPackageController.instance, OptionPackageEvent.UnZipProgressRefresh, self._onUnZipProgress, self)
	self.addEventCb(self, OptionPackageController.instance, OptionPackageEvent.DownladErrorMsg, self._onDownladErrorMsg, self)
end

function OptionPackageDownloadView:_show(percent, progressMsg)
	self._imageprogress.fillAmount = percent
	self._txtpercent.text = progressMsg
end

function OptionPackageDownloadView:_onDownloadProgress(packName, downloadSize, totalSize)
	local percent = downloadSize / totalSize
	local s1 = HotUpdateMgr.fixSizeStr(downloadSize)
	local s2 = HotUpdateMgr.fixSizeStr(totalSize)

	self._downProgressS1 = s1
	self._downProgressS2 = s2

	local progressMsg

	self:_show(percent, UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork and string.format(booterLang("download_info_wifi"), s1, s2) or string.format(booterLang("download_info"), s1, s2))
end

function OptionPackageDownloadView:_onUnZipProgress(progress)
	if not self._downProgressS1 then
		if not self._downProgressS2 then
			local s2 = ""
			local progressInt = math.floor(100 * progress + 0.5)
			local progressMsg

			self._txtpercent.text = UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork and string.format(booterLang("unziping_progress_wifi"), tostring(progressInt), self._downProgressS1, s2) or string.format(booterLang("unziping_progress"), tostring(progressInt), self._downProgressS1, s2)
		end
	end
end

function OptionPackageDownloadView:_closeInvokeCallback(isYes)
	self:_showMessgeBoxGo(false)

	local msgInfo = self._errorMsgInfo

	self._errorMsgInfo = nil

	if msgInfo then
		if isYes == true then
			if msgInfo.yesCallback then
				msgInfo.yesCallback(msgInfo.yesCallbackObj)
			end
		elseif msgInfo.noCallback then
			msgInfo.noCallback(msgInfo.noCallbackObj)
		end
	end
end

function OptionPackageDownloadView:_showMessgeBoxGo(v)
	gohelper.setActive(self._gomessgeBox, v)
	gohelper.setActive(self._goprogress, v == false)
end

function OptionPackageDownloadView:_showErrorUI()
	self:_showMessgeBoxGo(self._errorMsgInfo ~= nil)

	if self._errorMsgInfo then
		self._txtdesc.text = self._errorMsgInfo.msg

		if not self._errorMsgInfo.yesStr then
			local yesStr = luaLang("confirm")

			if not self._errorMsgInfo.noStr then
				local noStr = luaLang("cancel")

				if not self._errorMsgInfo.yesStrEn then
					local yesStrEn = "CONFIRM"

					if not self._errorMsgInfo.noStrEn then
						self._txtYes.text = self._errorMsgInfo.yesStr
						self._txtNo.text = noStr
						self._txtYesen.text = yesStrEn
						self._txtNoen.text = "CANCEL"
					end
				end
			end
		end
	end
end

function OptionPackageDownloadView:_onDownladErrorMsg(msgInfo)
	self._errorMsgInfo = msgInfo

	self:_showErrorUI()
end

return OptionPackageDownloadView
