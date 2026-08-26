-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEndingView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEndingView", package.seeall)

local V1a6_CachotEndingView = class("V1a6_CachotEndingView", BaseView)

function V1a6_CachotEndingView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagecg = gohelper.findChildSingleImage(self.viewGO, "#simage_cg")
	self._txten = gohelper.findChildText(self.viewGO, "#txt_en")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._txttips = gohelper.findChildText(self.viewGO, "#txt_tips")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotEndingView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotEndingView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotEndingView:_btncloseOnClick()
	V1a6_CachotController.instance:openV1a6_CachotResultView()
	self:closeThis()
end

function V1a6_CachotEndingView:_editableInitView()
	return
end

function V1a6_CachotEndingView:onUpdateParam()
	return
end

function V1a6_CachotEndingView:onOpen()
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotEndingView, self._btncloseOnClick, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_finale_get)
	self:refreshUI()
end

function V1a6_CachotEndingView:refreshUI()
	local rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()
	local endingId = rogueEndingInfo and rogueEndingInfo._ending
	local endingCfg = lua_rogue_ending.configDict[endingId]

	if endingCfg then
		self._txttitle.text = tostring(endingCfg.title)
		self._txttips.text = tostring(endingCfg.endingDesc)

		self._simagecg:LoadImage(ResUrl.getV1a6CachotIcon(endingCfg.endingIcon))
	end
end

function V1a6_CachotEndingView:onClose()
	return
end

function V1a6_CachotEndingView:onDestroyView()
	return
end

return V1a6_CachotEndingView
