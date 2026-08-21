-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/uifollow/RogueMapProperty.lua

module("logic.extensions.roguelike.view.explore.uifollow.RogueMapProperty", package.seeall)

local M = class("RogueMapProperty", IBattleReusable)
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kUnitsRoot = goutil.create("RogueMapProperty")

goutil.addChildToParent(kUnitsRoot, kSceneRoot)

function M:ctor()
	self.rootGO = goutil.create("UIRogueMapProperty", true)

	goutil.addChildToParent(self.rootGO, kUnitsRoot)

	self.mainGO = false
	self._url = false
end

function M:reuse()
	goutil.setActive(self.rootGO, true)
end

function M:reset()
	goutil.setActive(self.rootGO, false)
end

function M:destroy()
	self:_clearResource()

	self._url = false

	if self.rootGO then
		goutil.destroy(self.rootGO)

		self.rootGO = false
	end
end

function M:_clearResource()
	if self.mainGO then
		self:destroyUI()
		goutil.destroy(self.mainGO)

		self.mainGO = false
	end

	self._url = false
end

function M:buidUI()
	return
end

function M:destroyUI()
	return
end

function M:setMainGo(mainGO)
	self:_clearResource()
	goutil.addChildToParent(mainGO, self.rootGO)

	self.mainGO = mainGO

	self:buidUI()
end

function M:forecast(forecastResult)
	local p1 = forecastResult.fromHp / forecastResult.maxHp
	local p2 = forecastResult.toHp / forecastResult.maxHp

	if p2 <= p1 then
		self._imgBloodBarBg.fillAmount = p1
		self._imgBloodBarFg.fillAmount = p2
	else
		self._imgBloodBarBg.fillAmount = p2
		self._imgBloodBarFg.fillAmount = p1
	end
end

return M
