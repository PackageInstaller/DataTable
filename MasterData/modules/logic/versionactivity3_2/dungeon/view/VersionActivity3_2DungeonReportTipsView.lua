-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/VersionActivity3_2DungeonReportTipsView.lua

module("modules.logic.versionactivity3_2.dungeon.view.VersionActivity3_2DungeonReportTipsView", package.seeall)

local VersionActivity3_2DungeonReportTipsView = class("VersionActivity3_2DungeonReportTipsView", BaseView)

function VersionActivity3_2DungeonReportTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "#simage_pic")
	self._scrolltips = gohelper.findChildScrollRect(self.viewGO, "#scroll_tips")
	self._txttitle = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#txt_title")
	self._txtdec = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#txt_dec")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "bottom/#txt_dec2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_2DungeonReportTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity3_2DungeonReportTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity3_2DungeonReportTipsView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity3_2DungeonReportTipsView:_editableInitView()
	self._txtdec2.text = ""
end

function VersionActivity3_2DungeonReportTipsView:onUpdateParam()
	return
end

function VersionActivity3_2DungeonReportTipsView:onOpen()
	local list = VersionActivity3_2DungeonConfig.instance:getOptionConfigs()
	local countTable = {}
	local maxNum = 0
	local maxValue = 0

	for i, v in ipairs(list) do
		local record = DungeonMapModel.instance:getRecordInfo(v.id)

		record = tonumber(record)

		if record then
			if not countTable[record] then
				local num = 0
				local num = num + 1

				countTable[record] = num

				if maxNum < num then
					maxNum = num
					maxValue = record
				end
			end
		end
	end

	if maxValue == 0 then
		maxValue = 1

		logError("VersionActivity3_2DungeonReportTipsView maxValue == 0")
	end

	local config = lua_v3a2_chapter_result.configList[maxValue]

	self._txttitle.text = config.title
	self._txtdec.text = config.desc

	self._simagepic:LoadImage(string.format("singlebg/v3a2_dungeon_singlebg/%s.png", config.res))
	AudioMgr.instance:trigger(AudioEnum3_2.VersionActivity3_2.ui_wenming_cards_toushi)
end

function VersionActivity3_2DungeonReportTipsView:onClose()
	return
end

function VersionActivity3_2DungeonReportTipsView:onDestroyView()
	return
end

return VersionActivity3_2DungeonReportTipsView
