-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitRefreshProducts.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitRefreshProducts", package.seeall)

local ArcadeSkillHitRefreshProducts = class("ArcadeSkillHitRefreshProducts", ArcadeSkillHitBase)

function ArcadeSkillHitRefreshProducts:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._useSkillId = tonumber(params[2])
end

function ArcadeSkillHitRefreshProducts:onHit()
	if self._context and self._context.target then
		self:addHiter(self._context.target)
	end

	local curRoom = ArcadeGameController.instance:getCurRoom()

	if curRoom and curRoom.resetGoods then
		curRoom:resetGoods()
	end
end

function ArcadeSkillHitRefreshProducts:onHitPrintLog()
	logNormal(string.format("%s==> 刷新当前房间内的商品类交互物", self:getLogPrefixStr()))
end

return ArcadeSkillHitRefreshProducts
