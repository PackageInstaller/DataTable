-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_TeamRecommendTipsLoader.lua

module("modules.logic.rouge2.common.comp.Rouge2_TeamRecommendTipsLoader", package.seeall)

local Rouge2_TeamRecommendTipsLoader = class("Rouge2_TeamRecommendTipsLoader", LuaCompBase)

function Rouge2_TeamRecommendTipsLoader.Load(go, showType)
	if gohelper.isNil(go) then
		logError("Rouge2_TeamRecommendTipsLoader.Load error !!! go is nil")

		return
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_TeamRecommendTipsLoader, showType)
end

function Rouge2_TeamRecommendTipsLoader.LoadWithParams(go, showType, careerId, params)
	local loader = Rouge2_TeamRecommendTipsLoader.Load(go, showType)

	if loader then
		loader:initInfo(careerId, params)

		return loader
	end
end

function Rouge2_TeamRecommendTipsLoader:ctor(showType)
	self._showType = showType or Rouge2_Enum.TeamRecommendTipType.Default
	self._initInfoDone = false
end

function Rouge2_TeamRecommendTipsLoader:init(go)
	self.go = go
	self._loader = PrefabInstantiate.Create(go)

	self._loader:startLoad(Rouge2_Enum.ResPath.RecommendSystemTips, self._onLoadTipsDone, self)
end

function Rouge2_TeamRecommendTipsLoader:_onLoadTipsDone(loader)
	local goToolBar = loader:getInstGO()

	self._tipsItem = MonoHelper.addNoUpdateLuaComOnceToGo(goToolBar, Rouge2_TeamRecommendTips, self)

	self:_updateInfo()
end

function Rouge2_TeamRecommendTipsLoader:initInfo(careerId, params)
	self._careerId = careerId or Rouge2_Model.instance:getCareerId()
	self._params = params
	self._initInfoDone = true

	self:_updateInfo()
end

function Rouge2_TeamRecommendTipsLoader:updateCareerId(careerId)
	if not careerId or self._careerId == careerId then
		return
	end

	self._careerId = careerId

	self:_updateInfo()
end

function Rouge2_TeamRecommendTipsLoader:updateParams(params)
	self._params = params

	self:_updateInfo()
end

function Rouge2_TeamRecommendTipsLoader:_updateInfo()
	if not self._tipsItem or not self._initInfoDone then
		return
	end

	self._tipsItem:updateInfo(self._showType, self._careerId, self._params)
end

function Rouge2_TeamRecommendTipsLoader:onDestroy()
	self._loader = nil
end

return Rouge2_TeamRecommendTipsLoader
