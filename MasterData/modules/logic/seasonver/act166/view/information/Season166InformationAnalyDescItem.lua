-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationAnalyDescItem.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyDescItem", package.seeall)

local Season166InformationAnalyDescItem = class("Season166InformationAnalyDescItem", Season166InformationAnalyDetailItemBase)

function Season166InformationAnalyDescItem:onInit()
	self.txtDesc = gohelper.findChildTextMesh(self.go, "#txt_Descr")
	self.goLine = gohelper.findChild(self.go, "#txt_Descr/image_Line")
end

function Season166InformationAnalyDescItem:onUpdate()
	if self.txtFadeIn and self.txtFadeIn:isPlaying() then
		self.txtFadeIn:conFinished()
		self.txtFadeIn:onDestroy()
	end

	self.txtDesc.text = self.data.config.content
end

function Season166InformationAnalyDescItem:playFadeIn()
	self.txtFadeIn = self.txtFadeIn or MonoHelper.addNoUpdateLuaComOnceToGo(self.txtDesc.gameObject, TMPFadeInWithScroll)

	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_feichi_yure_caption)
	self.txtFadeIn:playNormalText(self.data.config.content, self.onTextFinish, self)
end

function Season166InformationAnalyDescItem:onTextFinish()
	AudioMgr.instance:trigger(AudioEnum.Season166.stop_ui_feichi_yure_caption)
end

function Season166InformationAnalyDescItem:onDestroy()
	AudioMgr.instance:trigger(AudioEnum.Season166.stop_ui_feichi_yure_caption)
	Season166InformationAnalyDescItem.super.onDestroy(self)
end

return Season166InformationAnalyDescItem
