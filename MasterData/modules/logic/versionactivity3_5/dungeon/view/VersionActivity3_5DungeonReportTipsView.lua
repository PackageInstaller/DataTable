-- chunkname: @modules/logic/versionactivity3_5/dungeon/view/VersionActivity3_5DungeonReportTipsView.lua

module("modules.logic.versionactivity3_5.dungeon.view.VersionActivity3_5DungeonReportTipsView", package.seeall)

local VersionActivity3_5DungeonReportTipsView = class("VersionActivity3_5DungeonReportTipsView", BaseView)

function VersionActivity3_5DungeonReportTipsView:onInitView()
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

function VersionActivity3_5DungeonReportTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity3_5DungeonReportTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity3_5DungeonReportTipsView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity3_5DungeonReportTipsView:_editableInitView()
	self._txtdec2.text = ""
end

function VersionActivity3_5DungeonReportTipsView:onUpdateParam()
	return
end

function VersionActivity3_5DungeonReportTipsView:onOpen()
	local list = VersionActivity3_5DungeonConfig.instance:getOptionConfigs()
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

		logError("VersionActivity3_5DungeonReportTipsView maxValue == 0")
	end

	local config = VersionActivity3_5DungeonConfig.instance:getChapterResult(maxValue)

	self._txttitle.text = config.title
	self._txtdec.text = config.desc

	self._simagepic:LoadImage(ResUrl.getV3a4SingleBg(config.res))
	AudioMgr.instance:trigger(AudioEnum3_5.VersionActivity3_5.ui_wenming_cards_toushi)
end

function VersionActivity3_5DungeonReportTipsView:onClose()
	return
end

function VersionActivity3_5DungeonReportTipsView:onDestroyView()
	return
end

return VersionActivity3_5DungeonReportTipsView
