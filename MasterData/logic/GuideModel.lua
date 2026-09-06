-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/GuideModel.lua

module("logic.extensions.guide.model.GuideModel", package.seeall)

local GuideModel = class("GuideModel", BaseListModel)

function GuideModel:ctor()
	GuideModel.super.ctor(self)

	self._currGuides = nil
	self._branSequeces = nil
	self._guidingBranch = nil
	self._willRemoveUi = nil
end

function GuideModel:onReset()
	GuideModel.super.onReset(self)

	self._willRemoveUi = nil
	self._branSequeces = nil
	self._currGuides = nil
	self.svrGuideList = {}
	self._gainedIds = nil
end

function GuideModel:getSvrGuideDataById(branchId)
	self.svrGuideList = self.svrGuideList or {}

	return self.svrGuideList[branchId] or 0
end

function GuideModel:updateSvrGuideData(branchId, curId, forGMTestForce)
	self.svrGuideList = self.svrGuideList or {}

	local last = self.svrGuideList[branchId]

	if last == nil then
		self.svrGuideList[branchId] = curId

		return true
	elseif forGMTestForce or last ~= -1 and last ~= curId then
		self.svrGuideList[branchId] = curId

		return true
	end

	return false
end

function GuideModel:getWillRemoveUI()
	return self._willRemoveUi
end

function GuideModel:addWillRemoveUI(uiName)
	self._willRemoveUi = self._willRemoveUi or {}

	table.insert(self._willRemoveUi, uiName)
end

function GuideModel:getGuideBranch(branch)
	if self._currGuides then
		return self._currGuides[branch]
	end
end

function GuideModel:isGuiding()
	return self._guidingBranch and self._guidingBranch:isGuiding()
end

function GuideModel:getCurrGuideBranch()
	return self._guidingBranch
end

function GuideModel:startGuideBranch(guideBranch)
	self._guidingBranch = guideBranch

	if self._guidingBranch.branchId == 80 then
		print("")
	end

	print(">>>>>>> GuideModel:startGuideBranch", self._guidingBranch.branchId)

	if self._guidingBranch:startGuide() then
		GuideController.instance:finishGuide()
	end
end

function GuideModel:finishGuideBranch(branch)
	if self._guidingBranch and self._guidingBranch ~= branch then
		print(">>>>>>> GuideModel:finishGuideBranch", self._guidingBranch.branchId)
		self._guidingBranch:finishGuide()

		self._guidingBranch = nil
	end
end

function GuideModel:onServerGuideData(localGuideData, svrGuideData)
	self._currGuides = nil

	local guideCfg = GuideConfig.instance
	local allCfg = guideCfg:getGuideConfig()

	for branch, conf in pairs(allCfg) do
		if checknumber(branch) > 0 then
			if not localGuideData[branch] then
				if not svrGuideData[branch] then
					local svrId = 0
					local guideId = guideCfg:getBranchStartGuideId(branch)

					guideId = (localGuideData[branch] == GuideConst.INVALID_GUIDE_ID or svrId == GuideConst.INVALID_GUIDE_ID) and GuideConst.INVALID_GUIDE_ID or math.max(svrId, guideId)

					if guideId ~= GuideConst.INVALID_GUIDE_ID then
						local guideCfg = GuideConfig.instance:getGuide(branch, guideId)

						if guideCfg and checknumber(guideCfg.isClose) ~= 1 then
							self._currGuides = self._currGuides or {}
							self._branSequeces = self._branSequeces or {}
							self._currGuides[branch] = GuideBranchFactory.createBranch(branch, guideId)

							table.insert(self._branSequeces, branch)
						end
					end
				end
			end
		end
	end

	if self._branSequeces then
		table.sort(self._branSequeces)
	end
end

function GuideModel:checkGuidesNeedForceToOnEnterView(viewName)
	if not self._currGuides then
		return
	end

	for i = 1, #self._branSequeces do
		local v = self._currGuides[self._branSequeces[i]]

		if v then
			local forceId = v:onEnterView(viewName)

			if forceId and forceId > 0 then
				v:setGuide(forceId)
			end
		end
	end
end

function GuideModel:checkGuidesNeedForceToOnExitView(viewName)
	if not self._currGuides then
		return
	end

	for i = 1, #self._branSequeces do
		local v = self._currGuides[self._branSequeces[i]]

		if v then
			local forceId = v:onExitView(viewName)

			if forceId and forceId > 0 then
				if self._guidingBranch == v and self._guidingBranch:isGuiding() then
					self:finishGuideBranch()
				end

				v:setGuide(forceId)
			end
		end
	end
end

function GuideModel:checkGuidesNeedForceToInView(viewName, childName)
	if not self._currGuides then
		return
	end

	for i = 1, #self._branSequeces do
		local v = self._currGuides[self._branSequeces[i]]

		if v then
			local forceId = v:forceToInView(viewName, childName)

			if forceId and forceId > 0 then
				if self._guidingBranch == v and self._guidingBranch:isGuiding() then
					self:finishGuideBranch()
				end

				v:setGuide(forceId)
			end
		end
	end
end

function GuideModel:checkGuidesNeedForceToInScene(sceneId, sceneType)
	if not self._currGuides then
		return
	end

	for i = 1, #self._branSequeces do
		local v = self._currGuides[self._branSequeces[i]]

		if v then
			local forceId = v:forceToInScene(sceneId, sceneType)

			if forceId and forceId > 0 then
				if self._guidingBranch == v and self._guidingBranch:isGuiding() then
					self:finishGuideBranch()
				end

				v:setGuide(forceId)
			end
		end
	end
end

function GuideModel:getGuideBranchWithScene(sceneId, sceneType)
	if not self._currGuides then
		return
	end

	for i = 1, #self._branSequeces do
		local v = self._currGuides[self._branSequeces[i]]

		if v then
			local guide = v:getGuide()

			if guide and guide:isTriggeredInScene(sceneId, sceneType) and v:shouldTrigger() then
				return v
			end
		end
	end
end

function GuideModel:getGuideBranchWithView(viewName, childName)
	if not self._currGuides then
		return
	end

	for i = 1, #self._branSequeces do
		local v = self._currGuides[self._branSequeces[i]]

		if v then
			local guide = v:getGuide()

			if guide and guide:isTriggeredInView(viewName, childName) and v:shouldTrigger() then
				return v
			end
		end
	end
end

function GuideModel:getGuideBranchWithTaskId(taskId)
	if not self._currGuides then
		return
	end

	for i = 1, #self._branSequeces do
		local v = self._currGuides[self._branSequeces[i]]

		if v then
			local guide = v:getGuide()

			if guide and guide:isTriggeredInView() and guide:isTriggeredByTask(taskId) and v:shouldTrigger() then
				return v
			end
		end
	end
end

function GuideModel:toString()
	local tInfo = {}
	local cnt = 1
	local guideCfg = GuideConfig.instance
	local allCfg = guideCfg:getGuideConfig()

	for bId, conf in pairs(allCfg) do
		if checknumber(bId) > 0 then
			if not self._currGuides then
				local guideMap = {}
				local branch = guideMap[bId]

				if not branch then
					tInfo[cnt] = bId .. ":" .. GuideConst.INVALID_GUIDE_ID
					tInfo[cnt + 1] = ","
				else
					local guide = branch:getGuide()

					if guide then
						tInfo[cnt] = bId .. ":" .. guide:getGuideId()
						tInfo[cnt + 1] = ","
					else
						tInfo[cnt] = bId .. ":" .. GuideConst.INVALID_GUIDE_ID
						tInfo[cnt + 1] = ","
					end
				end

				cnt = cnt + 2
			end
		end
	end

	cnt = #tInfo

	if #tInfo > 1 then
		table.remove(tInfo, cnt)
	end

	local str = table.concat(tInfo)

	printInfo(">>>>>>", str)

	return str
end

function GuideModel:fromString(str)
	local branches = {}

	if not str or #str == 0 then
		return branches
	end

	local allBranches = string.split(str, ",")

	if allBranches then
		local cnt = #allBranches

		for i = 1, cnt do
			local guideId = string.split(allBranches[i], ":")

			branches[checknumber(guideId[1])] = checknumber(guideId[2])
		end
	end

	return branches
end

function GuideModel:setGainedIds(value)
	self._gainedIds = value
	self._gainedMap = {}

	for _, v in ipairs(self._gainedIds) do
		self._gainedMap[v] = true
	end
end

function GuideModel:getGainedById(id)
	return self._gainedMap and self._gainedMap[id]
end

function GuideModel:setGainedById(id)
	self._gainedMap = self._gainedMap or {}
	self._gainedMap[id] = true
end

GuideModel.instance = GuideModel.New()

return GuideModel
