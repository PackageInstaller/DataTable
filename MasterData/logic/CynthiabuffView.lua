-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/CynthiabuffView.lua

module("logic.extensions.timelimitedchallenge.view.cynthia.CynthiabuffView", package.seeall)

local CynthiabuffView = class("CynthiabuffView", ViewComponent)

function CynthiabuffView:unbindEvents()
	CynthiabuffView.super.unbindEvents(self)
	self.btnEnsure:RemoveClickListener()
end

function CynthiabuffView:bindEvents()
	CynthiabuffView.super.bindEvents(self)
	self.btnEnsure:AddClickListener(self.close, self)
end

function CynthiabuffView:buildUI()
	CynthiabuffView.super.buildUI(self)

	self.btnEnsure = self:getBtn("btnEnsure")
	self.tip1 = self:getTxt("tip1")
	self.tip2 = self:getTxt("tip2")
end

function CynthiabuffView:onEnter()
	CynthiabuffView.super.onEnter(self)

	self._challengeId = checknumber(self:getFirstParam())

	local buffCfgs = CynthiaConfig.instance:getBuffCfgs(self._challengeId)
	local totalLv = #buffCfgs
	local mo = CynthiaModel.instance:getActMo(self._challengeId)
	local curLv = mo.buffLv
	local curCfg = CynthiaConfig.instance:getBuffCfg(self._challengeId, curLv)
	local lastCfg = CynthiaConfig.instance:getBuffCfg(self._challengeId, totalLv)

	self.tip1.text = langPara("最高可升至LV.%s,%s", totalLv, lastCfg.des)
	self.tip2.text = langPara("LV.%s,%s", curLv, curCfg.des)
end

return CynthiabuffView
