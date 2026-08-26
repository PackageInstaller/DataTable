-- chunkname: @modules/logic/rouge/define/RougeBaseDLCViewComp.lua

module("modules.logic.rouge.define.RougeBaseDLCViewComp", package.seeall)

local RougeBaseDLCViewComp = class("RougeBaseDLCViewComp", BaseViewExtended)

function RougeBaseDLCViewComp:_updateVersion()
	local season = self:getSeason()
	local versions = self:getVersions()

	self:killAllChildView()

	for _, version in pairs(versions or {}) do
		local clsName = string.format("%s_%s_%s", self.viewName, season, version)
		local cls = _G[clsName]

		if cls then
			if not cls.AssetUrl then
				if not gohelper.findChild(self.viewGO, cls.ParentObjPath or "") then
					local goParent = self.viewGO

					self:openSubView(cls, cls.AssetUrl, goParent, self.viewParam)
				end
			end
		end
	end
end

function RougeBaseDLCViewComp:onOpen()
	self.addEventCb(self, RougeDLCController.instance, RougeEvent.UpdateRougeVersion, self._updateVersion, self)
	self:_updateVersion()
end

function RougeBaseDLCViewComp:getSeason()
	return RougeOutsideModel.instance:season()
end

function RougeBaseDLCViewComp:getVersions()
	local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()

	return gameRecordInfo and gameRecordInfo:getVersionIds()
end

return RougeBaseDLCViewComp
