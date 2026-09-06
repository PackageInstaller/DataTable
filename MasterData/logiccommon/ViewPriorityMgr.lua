-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/ViewPriorityMgr.lua

module("logiccommon.common.viewlib.ViewPriorityMgr", package.seeall)

local ViewPriorityMgr = class("ViewPriorityMgr")

ViewPriorityMgr.StoryMaskViewPriority = 1
ViewPriorityMgr.BonusViewPriority = 40
ViewPriorityMgr.PopupWindowViewPriority = 300
ViewPriorityMgr.PetManualViewPriority = 110
ViewPriorityMgr.SummonContractViewPriority = 130
ViewPriorityMgr.TaskCompeleteViewPriority = 207
ViewPriorityMgr.PetDisplayViewPriority = 206
ViewPriorityMgr.PetUpgradeViewPriority = 205
ViewPriorityMgr.ObtainItemsViewPriority = 204
ViewPriorityMgr.PetMaxPowerChangePriority = 204
ViewPriorityMgr.MofangViewPriority = 202
ViewPriorityMgr.FuncOpenViewPriority = 201
ViewPriorityMgr.AchievementTipsViewPriority = 200
ViewPriorityMgr.StoryViewPriority = 400
ViewPriorityMgr.PopupBuffViewPriority = 199
ViewPriorityMgr.LotteryEffectViewPriority = 198

local priorityViews = {}

function ViewPriorityMgr:ctor()
	return
end

function ViewPriorityMgr:onOpenView(presentor)
	local isInView = self:_isInPriorityViewsList(presentor)

	if not isInView then
		self:_pushPriorityViewsList(presentor)
	end

	self:_sortPriorityViewsList()
end

function ViewPriorityMgr:handleViewsPriority()
	local cnt = #priorityViews

	if cnt > 0 then
		local highestView = priorityViews[1]

		self:_showViews(highestView.views)

		for i = 2, cnt do
			self:_hideViews(priorityViews[i].views)
		end
	end
end

function ViewPriorityMgr:popPriorityViewsList(presentor)
	if priorityViews then
		local cnt = #priorityViews

		for i = 1, cnt do
			if priorityViews[i].priority == presentor.priority and priorityViews[i].views then
				local views = priorityViews[i].views

				for j = 1, #views do
					if views[j] == presentor then
						table.remove(views, j)

						if #views == 0 then
							table.remove(priorityViews, i)
						end

						return
					end
				end
			end
		end
	end
end

function ViewPriorityMgr:_showViews(views)
	if views then
		local cnt = #views

		for i = 1, cnt do
			if views[i]._status ~= ViewPresentor.kViewStatusClosing and views[i]._status ~= ViewPresentor.kViewStatusClose and views[i].mainGO and not goutil.isNil(views[i].mainGO) and not views[i].mainGO.activeSelf and not ViewMgr.instance:isIngorePriority(views[i].viewName) then
				views[i]:showSelf()

				if views[i]._onViewShowByHigherPriority then
					views[i]:_onViewShowByHigherPriority()
				end
			end
		end
	end
end

function ViewPriorityMgr:_hideViews(views)
	if views then
		local cnt = #views

		for i = 1, cnt do
			if views[i].mainGO and views[i].mainGO.activeSelf and not ViewMgr.instance:isIngorePriority(views[i].viewName) then
				views[i]:hideSelf()
				print(">>>>>>>>>>>> ViewPriorityMgr 【隐藏界面】 : ", views[i].viewName)

				if views[i]._onViewHideByLowerPriority then
					views[i]:_onViewHideByLowerPriority()
				end
			end
		end
	end
end

function ViewPriorityMgr:_pushPriorityViewsList(presentor)
	local cnt = #priorityViews
	local views

	for i = 1, cnt do
		if priorityViews[i].priority == presentor.priority then
			views = priorityViews[i].views

			break
		end
	end

	if views then
		table.insert(views, presentor)
	else
		local cfg = {}

		cfg.priority = presentor.priority
		cfg.views = {}

		table.insert(cfg.views, presentor)
		table.insert(priorityViews, cfg)
	end
end

function ViewPriorityMgr:_sortPriorityViewsList()
	table.sort(priorityViews, function(first, second)
		if first == second then
			return false
		end

		if first.priority < second.priority then
			return false
		end

		if first.priority > second.priority then
			return true
		end

		return false
	end)
end

function ViewPriorityMgr:_isInPriorityViewsList(presentor)
	local cnt = #priorityViews

	for i = 1, cnt do
		if priorityViews[i].priority == presentor.priority then
			for j = 1, #priorityViews[i].views do
				if priorityViews[i].views[j] == presentor then
					return true
				end
			end
		end
	end
end

ViewPriorityMgr.instance = ViewPriorityMgr.New()

return ViewPriorityMgr
