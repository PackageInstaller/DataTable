-- chunkname: @modules/logic/help/view/HelpPageVideoView.lua

module("modules.logic.help.view.HelpPageVideoView", package.seeall)

local HelpPageVideoView = class("HelpPageVideoView", BaseView)

function HelpPageVideoView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function HelpPageVideoView:addEvents()
	return
end

function HelpPageVideoView:removeEvents()
	return
end

function HelpPageVideoView:_editableInitView()
	self._voideItem = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, HelpContentVideoItem, self)
	self._voideItem._view = self
end

function HelpPageVideoView:onUpdateParam()
	return
end

function HelpPageVideoView:onOpen()
	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, HelpEvent.UIVoideFullScreenChange, self._onVoideFullScreenChange, self)
		self.addEventCb(self, self.viewContainer, HelpEvent.UIPageTabSelectChange, self._onUIPageTabSelectChange, self)
	end
end

function HelpPageVideoView:onClose()
	return
end

function HelpPageVideoView:onDestroyView()
	self._voideItem:onDestroy()
end

function HelpPageVideoView:_onVoideFullScreenChange(isfull)
	if self.viewContainer and self.viewContainer.setVideoFullScreen then
		self.viewContainer:setVideoFullScreen(self._voideItem:getIsFullScreen())
	end
end

function HelpPageVideoView:_onUIPageTabSelectChange(pageTabCfg)
	self:setPageTabCfg(pageTabCfg)
end

function HelpPageVideoView:setPageTabCfg(cfg)
	if not cfg then
		return
	end

	if cfg.showType == HelpEnum.PageTabShowType.Video and self._curShowHelpId ~= cfg.helpId then
		self._curShowHelpId = cfg.helpId

		local videoCfg = HelpConfig.instance:getHelpVideoCO(self._curShowHelpId)

		if videoCfg then
			self._voideItem:onUpdateMO(videoCfg)
		else
			logError(string.format("export_帮助视频表 can not find id : %s", self._curShowHelpId))
		end
	elseif cfg.showType ~= HelpEnum.PageTabShowType.Video then
		self._voideItem:stop()
	end
end

return HelpPageVideoView
