-- chunkname: @modules/logic/gm/view/GMAudioBankViewItem.lua

module("modules.logic.gm.view.GMAudioBankViewItem", package.seeall)

local GMAudioBankViewItem = class("GMAudioBankViewItem", ListScrollCell)

function GMAudioBankViewItem:init(go)
	self._guideCO = nil
	self._txtAudioId = gohelper.findChildText(go, "txtAudioID")
	self._txtEventName = gohelper.findChildText(go, "txtEventName")
	self._btnShow = gohelper.findChildButtonWithAudio(go, "btnShow")

	self._btnShow:AddClickListener(self._onClickShow, self)
end

function GMAudioBankViewItem:onUpdateMO(config)
	self._audioCO = config
	self._configId = config.id
	self._txtAudioId.text = self._configId
	self._txtEventName.text = self._audioCO.eventName
end

function GMAudioBankViewItem:_onClickShow()
	AudioMgr.instance:trigger(3000031)
	AudioMgr.instance:trigger(self._configId)
end

function GMAudioBankViewItem:onDestroy()
	self._btnShow:RemoveClickListener()
end

return GMAudioBankViewItem
