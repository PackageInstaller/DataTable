-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/view/OriginLongYanClgBattleExView.lua

module("logic.extensions.originlongyanclg.view.OriginLongYanClgBattleExView", package.seeall)

local OriginLongYanClgBattleExView = class("OriginLongYanClgBattleExView", ViewComponent)

function OriginLongYanClgBattleExView:ctor()
	OriginLongYanClgBattleExView.super.ctor(self)
end

function OriginLongYanClgBattleExView:unbindEvents()
	OriginLongYanClgBattleExView.super.unbindEvents(self)
end

function OriginLongYanClgBattleExView:bindEvents()
	OriginLongYanClgBattleExView.super.bindEvents(self)
end

function OriginLongYanClgBattleExView:buildUI()
	OriginLongYanClgBattleExView.super.buildUI(self)

	self._txt = self:getTxt("info/txt")
	self._info = self:getGo("info")
end

function OriginLongYanClgBattleExView:onExit()
	OriginLongYanClgBattleExView.super.onExit(self)
end

function OriginLongYanClgBattleExView:onEnter()
	OriginLongYanClgBattleExView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BuffLayerNumChange, self._onBuffLayerNumChange, self)

	local stageCfg = OriginLongYanClgController.instance:getExBuffParam()

	self._isTri = false

	goutil.setActive(self._info, false)

	self._buffMap = {}

	if stageCfg then
		local activityId = stageCfg.activityId

		if not stageCfg.positionSignId then
			for _, signId in pairs(stageCfg.positionSignId) do
				if signId and signId > 0 and not self._buffMap[signId] then
					local signCfg = OriginLongYanClgConfig.instance:getSignCfgById(activityId, signId)

					if signCfg then
						local parma = {}

						parma.signCfg = signCfg
						parma.curLayoutNum = 0
						self._buffMap[checknumber(signCfg.signProgressBuffId)] = parma
					end
				end
			end
		end
	else
		self._isTri = true
	end
end

function OriginLongYanClgBattleExView:_onBuffLayerNumChange(buff)
	if self._isTri then
		return
	end

	local parma = self._buffMap[(buff and buff:getBuffId() or nil) and checknumber(buff:getBuffId())]

	if parma and parma.signCfg then
		parma.curLayoutNum = buff.layerNum

		if parma.curLayoutNum >= parma.signCfg.needLayoutNum then
			parma.curLayoutNum = parma.signCfg.needLayoutNum
			self._txt.text = string.format("已注入<color=#eb4642>%s<color>意志", parma.signCfg.signName or "未知")
			self._isTri = true

			goutil.setActive(self._info, true)
		end
	end
end

return OriginLongYanClgBattleExView
