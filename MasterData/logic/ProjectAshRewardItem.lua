-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshRewardItem.lua

module("logic.extensions.projectash.view.ProjectAshRewardItem", package.seeall)

local ProjectAshRewardItem = class("ProjectAshRewardItem")

function ProjectAshRewardItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	self._noGet = goutil.findChild(go, "noGet")
	self._btnCanGet = Framework.ButtonAdapter.GetFrom(go, "btnCanGet")
	self._geted = goutil.findChild(go, "geted")
	self._cell = goutil.findChild(go, "tableview/item")
	self._tableview = goutil.findChild(go, "tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._btnCanGet:AddClickListener(self._onClick, self)
end

function ProjectAshRewardItem:init(data, activityId)
	self._activityId = activityId
	self._data = data
	self._prizeType = ProjectAshModel.PrizeType.stage2DamagePrize
	self._txtDesc.text = data.desc

	local list = {}

	table.insert(list, data.prize)
	self._scrollList:reloadData(list)

	local myDamage = ProjectAshModel.instance:getMyDamage()
	local isGeted = ProjectAshModel.instance:isPlayerRewardGeted(self._prizeType, data.id)
	local isCanGet = myDamage >= checknumber(data.progress)

	goutil.setActive(self._noGet, not isGeted and not isCanGet)
	goutil.setActive(self._btnCanGet.gameObject, isCanGet and not isGeted)
	goutil.setActive(self._geted, isGeted)
end

function ProjectAshRewardItem:reset()
	self._scrollList:dispose()
end

function ProjectAshRewardItem:_onClick()
	ProjectAshAgent.instance:sendPM_ProjectAshGainPrizeReq(self._activityId, self._prizeType, self._data.id)
end

function ProjectAshRewardItem:_updateCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function ProjectAshRewardItem:_clearCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll()
end

return ProjectAshRewardItem
