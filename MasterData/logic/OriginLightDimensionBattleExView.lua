-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionBattleExView.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionBattleExView", package.seeall)

local OriginLightDimensionBattleExView = class("OriginLightDimensionBattleExView", ViewComponent)

function OriginLightDimensionBattleExView:ctor()
	OriginLightDimensionBattleExView.super.ctor(self)
end

function OriginLightDimensionBattleExView:unbindEvents()
	OriginLightDimensionBattleExView.super.unbindEvents(self)
end

function OriginLightDimensionBattleExView:bindEvents()
	OriginLightDimensionBattleExView.super.bindEvents(self)
end

function OriginLightDimensionBattleExView:buildUI()
	OriginLightDimensionBattleExView.super.buildUI(self)

	self._txt = self:getTxt("info/txt")
	self._info = self:getGo("info")
end

function OriginLightDimensionBattleExView:onExit()
	OriginLightDimensionBattleExView.super.onExit(self)
end

function OriginLightDimensionBattleExView:onEnter()
	OriginLightDimensionBattleExView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OnBattleBuffEnd, self._onBuffLayerNumChange, self)

	local stageCfg = OriginLightDimensionController.instance:getExBuffParam()

	goutil.setActive(self._info, false)

	self._buffMap = {}

	if stageCfg then
		self._activityId = stageCfg.activityId

		local buffCfgs = OriginLightDimensionConfig.instance:getExtremeBuffCfgs(self._activityId)

		for _, buffCfg in pairs(buffCfgs) do
			self._buffMap[checknumber(buffCfg.buffId)] = 0
		end

		local lastBuff = OriginLightDimensionModel.instance:getTempExtClgLastBuff()
		local lastBuffCfg = OriginLightDimensionConfig.instance:getExtremeBuffCfg(self._activityId, lastBuff)

		if lastBuffCfg then
			goutil.setActive(self._info, true)

			self._txt.text = langPara("当前激活：%s", lastBuffCfg.name)
		end
	end
end

function OriginLightDimensionBattleExView:_onBuffLayerNumChange(target, buff)
	if not self._activityId then
		return
	end

	if self._buffMap[(buff and buff.getBuffId or nil) and checknumber(buff:getBuffId())] ~= nil then
		local curBuff = 0
		local scene = SceneMgr.instance:getCurScene()
		local units = scene.unitFactory:getAllUnit()

		if not units then
			return
		end

		for k, v in pairs(units) do
			local sameUnits = v

			for k2, v2 in pairs(sameUnits) do
				local buffs = v2.buffList:getBuffs()

				for i, v3 in ipairs(buffs) do
					if self._buffMap[v3:getBuffId()] ~= nil then
						curBuff = v3:getBuffId()

						break
					end
				end

				if curBuff ~= 0 then
					break
				end
			end

			if curBuff ~= 0 then
				break
			end
		end

		local buffCfg = OriginLightDimensionConfig.instance:getExtremeBuffCfg(self._activityId, curBuff)

		goutil.setActive(self._info, true)

		self._txt.text = langPara("当前激活：%s", buffCfg.name)
	end
end

return OriginLightDimensionBattleExView
