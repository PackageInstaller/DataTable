-- chunkname: @IQIGame\\Scene\\MemoryStory\\Element\\MemoryStoryHero.lua

local MemoryStoryElement = require("IQIGame.Scene.MemoryStory.Element.MemoryStoryElement")
local m = {
	NextMoveNode = 0,
	CurMoveNode = 0
}

m = extend(MemoryStoryElement, m)

function m.New(controller, view)
	local obj = Clone(m)

	obj:__OnInit(controller, view)

	return obj
end

function m:__OnInit(controller, view)
	self:__Init(controller, view)
end

function m:__InitOrientations()
	self:__InitSpineRootOrientations()
	self:SetEntityDir(MemoryStoryModule.StorySceneCfg.Direction)
end

function m:__OnEntityPrepareSucceed(executeService)
	if self.goTaskTag ~= nil then
		self.goTaskTag.gameObject:SetActive(false)
	end

	self:__DoEntityPrepareSucceed(executeService)
end

function m:SetFree()
	self:StopWalk()
	self.viewRoot.gameObject:SetActive(false)
	self.viewRoot.transform:SetParent(nil)
end

function m:ReEnterScene()
	self.viewRoot.gameObject:SetActive(true)
end

function m:UpdateMoveNode(cur, next)
	self.CurMoveNode = cur
	self.NextMoveNode = next
end

function m:Walk(position)
	local pos = Vector3.New(position.x, position.y, 0)

	self.viewRoot.transform.localPosition = pos

	self:__PlayAnim("run", true)
end

function m:StopWalk()
	self:__PlayAnim("idle", true)

	if self.StopWalkAction ~= nil then
		self.StopWalkAction()

		self.StopWalkAction = nil
	end
end

return m
