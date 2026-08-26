-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/VersionActivityFixedDungeonReportTipsView1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.VersionActivityFixedDungeonReportTipsView1", package.seeall)

local VersionActivityFixedDungeonReportTipsView1 = class("VersionActivityFixedDungeonReportTipsView1", BaseView)

function VersionActivityFixedDungeonReportTipsView1:onInitView()
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

function VersionActivityFixedDungeonReportTipsView1:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivityFixedDungeonReportTipsView1:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivityFixedDungeonReportTipsView1:_btncloseOnClick()
	self:closeThis()
end

function VersionActivityFixedDungeonReportTipsView1:_editableInitView()
	self._txtdec2.text = ""
end

function VersionActivityFixedDungeonReportTipsView1:onUpdateParam()
	return
end

function VersionActivityFixedDungeonReportTipsView1:onOpen()
	local list = VersionActivityFixedDungeonConfig1.instance:getOptionConfigs()
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

		logError("VersionActivityFixedDungeonReportTipsView1 maxValue == 0")
	end

	local config = VersionActivityFixedDungeonConfig1.instance:getChapterResult(maxValue)

	self._txttitle.text = config.title
	self._txtdec.text = config.desc

	self._simagepic:LoadImage(ResUrl.getV3a4SingleBg(config.res))
	AudioMgr.instance:trigger(VersionActityFixedAudioEnum1.CommonAudio.ui_wenming_cards_toushi)
end

function VersionActivityFixedDungeonReportTipsView1:onClose()
	return
end

function VersionActivityFixedDungeonReportTipsView1:onDestroyView()
	return
end

return VersionActivityFixedDungeonReportTipsView1
