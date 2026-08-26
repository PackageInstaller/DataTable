-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186EffectView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186EffectView", package.seeall)

local Activity186EffectView = class("Activity186EffectView", BaseView)

function Activity186EffectView:onInitView()
	self.effectList = self:getUserDataTb_()

	for i = 1, 4 do
		self.effectList[i] = gohelper.findChild(self.viewGO, "#go_effect" .. i)
	end

	self.audioIdList = {
		[Activity186Enum.ViewEffect.Caidai] = AudioEnum.Act186.play_ui_tangren_banger,
		[Activity186Enum.ViewEffect.Yanhua] = AudioEnum.Act186.play_ui_tangren_firework,
		[Activity186Enum.ViewEffect.Jinsha] = AudioEnum.Act186.play_ui_tangren_mysticism,
		[Activity186Enum.ViewEffect.Xiangyun] = AudioEnum.Act186.play_ui_tangren_cloud
	}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186EffectView:addEvents()
	return
end

function Activity186EffectView:removeEvents()
	return
end

function Activity186EffectView:_editableInitView()
	return
end

function Activity186EffectView:onClickBtnClose()
	self:closeThis()
end

function Activity186EffectView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function Activity186EffectView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function Activity186EffectView:refreshParam()
	self.effectId = self.viewParam.effectId
end

function Activity186EffectView:refreshView()
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)

	for i, v in ipairs(self.effectList) do
		gohelper.setActive(v, false)

		if i == self.effectId then
			gohelper.setActive(v, true)
		end
	end

	local audioId = self.audioIdList[self.effectId]

	if audioId then
		AudioMgr.instance:trigger(audioId)
	end
end

function Activity186EffectView:onClose()
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)
end

function Activity186EffectView:onDestroyView()
	return
end

return Activity186EffectView
