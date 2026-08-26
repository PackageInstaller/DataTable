-- chunkname: @modules/logic/scene/view/LoadingDownloadView.lua

module("modules.logic.scene.view.LoadingDownloadView", package.seeall)

local LoadingDownloadView = class("LoadingDownloadView", BaseView)

function LoadingDownloadView:onInitView()
	self._progressBar = SLFramework.UGUI.SliderWrap.GetWithPath(self.viewGO, "progressBar")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtPercent = gohelper.findChildText(self.viewGO, "bottom_text/#txt_percent")
	self._txtWarn = gohelper.findChildText(self.viewGO, "bottom_text/#txt_actualnum")
	self._txtDescribe = gohelper.findChildText(self.viewGO, "describe_text/#txt_describe")
	self._txtTitle = gohelper.findChildText(self.viewGO, "describe_text/#txt_describe/title/#txt_title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "describe_text/#txt_describe/title/#txt_title_en")

	self:_setLoadingItem()
end

function LoadingDownloadView:onOpen()
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.ShowDownloadInfo, self._showDownloadInfo, self)
end

function LoadingDownloadView:onClose()
	gohelper.setActive(self.viewGO, false)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.ShowDownloadInfo, self._showDownloadInfo, self)
	self._simagebg:UnLoadImage()
end

function LoadingDownloadView:_showDownloadInfo(percent, progressMsg, warnningMsg)
	self:setPercent(percent)
	self:setProgressMsg(progressMsg)
	self:setWarnningMsg(warnningMsg)
end

function LoadingDownloadView:_getRandomCO(plist)
	local totalWeight = 0
	local list = {}

	for _, co in ipairs(plist) do
		local episodeId = co.episodeId

		if not episodeId or episodeId == 0 or LoginController.instance:isPassDungeonById(episodeId) then
			totalWeight = totalWeight + co.weight

			table.insert(list, co)
		end
	end

	local rand = math.floor(math.random() * totalWeight)

	for _, co in ipairs(list) do
		if rand < co.weight then
			return co
		else
			rand = rand - co.weight
		end
	end

	local randIndex = math.random(1, #list)

	return list[randIndex]
end

function LoadingDownloadView:_setLoadingItem()
	local txtCo = booterLoadingConfig()
	local loadTxt = self:_getRandomCO(txtCo)

	self._txtDescribe.text = loadTxt.desc
	self._txtTitle.text = loadTxt.title
	self._txtTitleEn.text = loadTxt.titleen

	self:_showDownloadInfo(0, luaLang("voice_package_update"))
	self._simagebg:LoadImage(ResUrl.getLoadingBg("full/originbg"))
end

function LoadingDownloadView:show(percent, progressMsg, warnningMsg)
	self:setPercent(percent)
	self:setProgressMsg(progressMsg)
	self:setWarnningMsg(warnningMsg)
end

function LoadingDownloadView:setPercent(percent)
	self._progressBar:SetValue(percent)
end

function LoadingDownloadView:setProgressMsg(progressMsg)
	self._txtPercent.text = progressMsg and progressMsg or ""
end

function LoadingDownloadView:setWarnningMsg(warnningMsg)
	self._txtWarn.text = warnningMsg and warnningMsg or ""
end

return LoadingDownloadView
