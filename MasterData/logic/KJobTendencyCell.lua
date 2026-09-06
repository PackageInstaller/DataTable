-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KJobTendencyCell.lua

module("logic.extensions.kindergarten.view.KJobTendencyCell", package.seeall)

local KJobTendencyCell = class("KJobTendencyCell")

function KJobTendencyCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	self._txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	self.scrollerGo = goutil.findChild(go, "tableview")
	self.cellGo = goutil.findChild(go, "tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function KJobTendencyCell:init(activityId, data)
	self._activityId = activityId
	self._txtTitle.text = data.name
	self._txtDesc.text = string.format("共%d人", data.totalNums)

	self._scrollList:reloadData(data.jobList)
end

function KJobTendencyCell:reset()
	self._scrollList:dispose()
end

function KJobTendencyCell:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local cfgJob = KindergartenConfig.instance:getJobCfg(self._activityId, data.jobId)

	txtDesc.text = cfgJob and string.format("%s：<color=#a66f35>%d</color>人", cfgJob.jobName, data.count) or "nil"
end

function KJobTendencyCell:clearCell(cell)
	return
end

return KJobTendencyCell
