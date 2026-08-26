-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotProgressListMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotProgressListMO", package.seeall)

local V1a6_CachotProgressListMO = pureTable("V1a6_CachotProgressListMO")

function V1a6_CachotProgressListMO:init(index, id, isLocked)
	self.index = index
	self.id = id
	self.isLocked = isLocked
end

function V1a6_CachotProgressListMO:getLineWidth()
	if not self.isLocked then
		return V1a6_CachotEnum.UnLockedRewardItemWidth
	end

	local scrollViews = V1a6_CachotProgressListModel.instance._scrollViews
	local scroll = scrollViews and scrollViews[1]
	local scrollWidth = 0

	if scroll then
		local csListView = scroll:getCsScroll()

		scrollWidth = recthelper.getWidth(csListView.transform)
	end

	local nearScrollEdgeDistance = (self.index - 1) * V1a6_CachotEnum.UnLockedRewardItemWidth - scrollWidth

	return (nearScrollEdgeDistance < 0 or nil) and math.abs(nearScrollEdgeDistance)
end

function V1a6_CachotProgressListMO:computeLockedItemWidth()
	return
end

return V1a6_CachotProgressListMO
