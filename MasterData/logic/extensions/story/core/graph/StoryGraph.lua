-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/StoryGraph.lua

module("logic.extensions.story.core.graph.StoryGraph", package.seeall)

local M = class("StoryGraph")

function M.CreateOLVerStruct()
	local olVer = {}

	olVer.data = nil
	olVer.firstIn = nil
	olVer.firstOut = nil

	return olVer
end

function M.CreateOLArcStruct()
	local olArc = {}

	olArc.headVex = -1
	olArc.tailVex = -1
	olArc.hlink = nil
	olArc.tlink = nil
	olArc.weight = -100000000

	return olArc
end

function M:ctor()
	self.m_olVer = {}
end

function M:Dispose()
	self.m_olVer = nil
end

function M:Reset()
	self.m_olVer = {}
end

function M:Build(shotList)
	if shotList == nil or #shotList == 0 then
		return
	end

	self:CreateOLVer(shotList, self.m_olVer)

	local arcList = self:CreateOLArc(shotList, self.m_olVer)

	self:ConnectArc(arcList, self.m_olVer)
end

function M:GetOutVer(currentShot, targetShotId)
	local ver = self:FindVer(self.m_olVer, currentShot)

	if ver == nil then
		return nil
	end

	if ver.firstOut == nil then
		return nil
	end

	if targetShotId == -1 then
		return self.m_olVer[ver.firstOut.headVex]
	end

	local temp = ver.firstOut

	while temp ~= nil do
		ver = self.m_olVer[temp.headVex]

		if ver ~= nil and ver.data.shotId == targetShotId then
			return ver
		end

		temp = temp.hlink
	end

	return nil
end

function M:SetArcWeight(tailShotId, headShotId, weight)
	if self.m_olVer == nil or #self.m_olVer == 0 then
		printError("StoryGraph.SetArcWeight -》 ", "graph is nil")

		return
	end

	for index, item in ipairs(self.m_olVer) do
		local temp = item.firstIn

		while temp ~= nil do
			local tailVer = self.m_olVer[temp.tailVex]
			local headVer = self.m_olVer[temp.headVex]

			if tailVer and tailVer.data.shotId == tailShotId and headVer.data.shotId == headShotId then
				temp.weight = weight

				return
			end

			temp = temp.tlink
		end
	end
end

function M:PrintOLGraph()
	if self.m_olVer == nil or #self.m_olVer == 0 then
		printError("StoryGraph.SetArcWeight -》 ", "graph is nil")

		return
	end

	for index, item in ipairs(self.m_olVer) do
		local temp = item.firstOut
		local sb = {}

		while temp ~= nil do
			local shot1 = self.m_olVer[temp.tailVex] and self.m_olVer[temp.tailVex].data
			local shot2 = self.m_olVer[temp.headVex] and self.m_olVer[temp.headVex].data

			table.insert(sb, (shot1 and shot1.shotId or "nil") .. "->" .. (shot2 and shot2.shotId or "nil") .. ",weight=" .. temp.weight)

			temp = temp.tlink
		end

		print(item.data.shotId .. "节点指向：" .. table.concat(sb, ";"))
	end
end

function M:GetShotPath(fromShot, toShot)
	local path = {}
	local ver = self:FindVer(self.m_olVer, fromShot)

	if self:RecurGetShotPath(path, ver, toShot) then
		table.insert(path, toShot)
	end

	return path
end

function M:RecurGetShotPath(path, fromVer, toShot)
	if not fromVer or fromVer.data == nil or toShot == nil then
		return false
	end

	if fromVer.data == toShot then
		return true
	end

	local temp = fromVer.firstOut

	while temp ~= nil do
		if temp.headVex >= 1 and temp.headVex <= #self.m_olVer then
			if self:RecurGetShotPath(path, self.m_olVer[temp.headVex], toShot) then
				table.insert(path, 1, fromVer.data)

				return true
			end
		else
			printError("树结构错误，请检查分支配置：", temp.tailVex, temp.headVex)
		end

		temp = temp.tlink
	end

	return false
end

function M:CreateOLVer(shotList, olVerList)
	for i = 1, #shotList do
		local shot = shotList[i]
		local ver = M.CreateOLVerStruct()

		ver.data = shot
		ver.firstIn = nil
		ver.firstOut = nil

		table.insert(olVerList, ver)
	end
end

function M:CreateOLArc(shotList, verList)
	local olArcList = {}
	local shotCount = #shotList

	for i = 1, shotCount do
		local shot = shotList[i]

		if shot:IsEnd() ~= true then
			if #shot.shotEdges == 0 then
				if i < shotCount then
					local arc = M.CreateOLArcStruct()

					arc.tailVex = self:FindVerIndex(verList, shot)

					if shot:IsEnd() then
						arc.headVex = -100
					else
						arc.headVex = self:FindVerIndex(verList, shotList[i + 1])
					end

					table.insert(olArcList, arc)
				end
			else
				local branchCount = #shot.shotEdges

				for j = 1, branchCount do
					local headShot = self:FindShot(shotList, shot.shotEdges[j].targetNodeGuid)
					local arc = M.CreateOLArcStruct()

					arc.tailVex = self:FindVerIndex(verList, shot)
					arc.headVex = self:FindVerIndex(verList, headShot)

					table.insert(olArcList, arc)
				end
			end
		end
	end

	return olArcList
end

function M:ConnectArc(arcList, olVerList)
	local olverCount = #olVerList

	for i = 1, olverCount do
		local ver = olVerList[i]
		local tempArc
		local arcListCount = #arcList

		for j = 1, arcListCount do
			if i == arcList[j].tailVex then
				if ver.firstOut == nil then
					ver.firstOut = arcList[j]
					tempArc = arcList[j]
				else
					tempArc.tlink = arcList[j]
					tempArc = arcList[j]
				end
			end
		end

		tempArc = nil

		for j = 1, arcListCount do
			if i == arcList[j].headVex then
				if ver.firstIn == nil then
					ver.firstIn = arcList[j]
					tempArc = arcList[j]
				else
					tempArc.hlink = arcList[j]
					tempArc = arcList[j]
				end
			end
		end
	end
end

function M:FindVerIndex(verList, targetStoryShot)
	if targetStoryShot == nil or verList == nil then
		return -1
	end

	for index, value in ipairs(verList) do
		if value.data == targetStoryShot then
			return index
		end
	end

	return -1
end

function M:FindVer(verList, targetStoryShot)
	if targetStoryShot == nil or verList == nil then
		return nil
	end

	for index, value in ipairs(verList) do
		if value.data == targetStoryShot then
			return value
		end
	end

	return nil
end

function M:FindShot(shots, shotId)
	if shots == nil then
		return nil
	end

	for index, value in ipairs(shots) do
		if value.shotId == shotId then
			return value
		end
	end

	return nil
end

return M
