-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EpisodeListCenter.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EpisodeListCenter", package.seeall)

local Season123_3_5EpisodeListCenter = class("Season123_3_5EpisodeListCenter", UserDataDispose)

function Season123_3_5EpisodeListCenter:ctor()
	self:__onInit()
end

function Season123_3_5EpisodeListCenter:dispose()
	self:__onDispose()
end

function Season123_3_5EpisodeListCenter:init(viewGO)
	self.viewGO = viewGO

	self:initComponent()
end

function Season123_3_5EpisodeListCenter:initComponent()
	self._txtmapname = gohelper.findChildText(self.viewGO, "#txt_mapname")
	self._goprogress = gohelper.findChild(self.viewGO, "progress")
	self._txtCurrent = gohelper.findChildTextMesh(self.viewGO, "progress/#go_progress/#txt_current")
	self._txtTotal = gohelper.findChildTextMesh(self.viewGO, "progress/#go_progress/#txt_total")
end

function Season123_3_5EpisodeListCenter:initData(actId, stage)
	self._actId = actId
	self._stageId = stage
end

function Season123_3_5EpisodeListCenter:refreshUI()
	if not self._stageId then
		return
	end

	local stageCO = Season123Config.instance:getStageCo(self._actId, self._stageId)

	if stageCO then
		self._txtmapname.text = stageCO.name
	end

	self:refreshProgress()
end

function Season123_3_5EpisodeListCenter:refreshProgress()
	local isShowStar = Season123ProgressUtils.isStageUnlock(self._actId, self._stageId)

	gohelper.setActive(self._goprogress, isShowStar)

	if isShowStar then
		local seasonMO = Season123Model.instance:getActInfo(self._actId)
		local stageMO = seasonMO:getStageMO(self._stageId)
		local current, total = stageMO:getProgressStar()

		self._txtCurrent.text = tostring(current)
		self._txtTotal.text = tostring(total)
	end
end

return Season123_3_5EpisodeListCenter
