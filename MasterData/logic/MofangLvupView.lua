-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mofang/view/MofangLvupView.lua

module("logic.extensions.mofang.view.MofangLvupView", package.seeall)

local MofangLvupView = class("MofangLvupView", ViewComponent)

function MofangLvupView:ctor()
	MofangLvupView.super.ctor(self)
end

function MofangLvupView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function MofangLvupView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function MofangLvupView:buildUI()
	self._closeButton = self:getBtn("img_bg")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "txtLv")
	self._txtHealth = goutil.findChildTextComponent(self.mainGO, "image/txtHealthTip")
	self._goFuncCell = goutil.findChild(self.mainGO, "vlayout/cell")

	self._goFuncCell:SetActive(false)

	self._listFuncOpenCellPool = {}
	self._listFuncOpenCellInUse = {}
	self._cells = ItemGroup.New(self:getGo("vlayout"))
	self._txtHealthLeft = goutil.findChildTextComponent(self.mainGO, "image/txtHealthTip")
	self._txtHealthRight = goutil.findChildTextComponent(self.mainGO, "image/txtHealthTip2")
end

function MofangLvupView:destroyUI()
	return
end

function MofangLvupView:onEnter()
	self:_createEffects()

	local curLv = MofangModel.instance:getCurLv()
	local preCfg = MofangConfig.instance:getCfgById(curLv - 1)
	local curCfg = MofangConfig.instance:getCfgById(curLv)
	local curHealth = SupplyModel.instance:getHaveTiliCount()
	local dHealth = checknumber(string.split(curCfg.strengthPrize, ":")[3])
	local preHealth = curHealth - dHealth

	self._txtLv.text = curLv
	self._txtHealthLeft.text = string.format("体力增加  %s", preHealth)
	self._txtHealthRight.text = string.format("%s(+%s)", curHealth, dHealth)

	local cfgList = FuncOpenConfig.instance:getLevelupTipCfgListByLevel(curLv)

	self._cells:updateWithMoArray(cfgList, function(item, mo)
		goutil.findChildTextComponent(item.mainGO, "txtName").text = mo.name
		goutil.findChildTextComponent(item.mainGO, "txtCondition").text = mo.condition
	end)

	self._isLockClose = true

	settimer(1, self.unlockClose, self)

	for _, eff in ipairs(self._effs) do
		eff:setActive(true)
	end
end

local effPaths = {
	{
		goPath = "point_bg",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_bg.prefab"
	},
	{
		goPath = "point_tisheng",
		path = "fx_ui_xunlianshidengji/fx_ui_xunlianshi_tisheng.prefab"
	},
	{
		goPath = "point_chixu",
		path = "fx_ui_xunlianshidengji/fx_ui_xunlianshi_texiaochixu.prefab"
	},
	{
		goPath = "point_yici",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_texiaoyici.prefab"
	}
}

function MofangLvupView:_createEffects()
	self._effs = {}

	for _, effPath in ipairs(effPaths) do
		local parent = self:getGo(effPath.goPath)
		local eff = UIEffectManager.instance:playHUDEffect(effPath.path, parent, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		end, nil, false)

		eff:setActive(false)
		table.insert(self._effs, eff)
	end
end

function MofangLvupView:unlockClose()
	self._isLockClose = false
end

function MofangLvupView:onEnterFinished()
	return
end

function MofangLvupView:onExit()
	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}
	self._isLockClose = false

	removetimer(self.unlockClose, self)
end

function MofangLvupView:onExitFinished()
	return
end

function MofangLvupView:_onClickClose()
	if self._isLockClose then
		return
	end

	self:close()
end

return MofangLvupView
