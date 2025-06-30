-- chunkname: @IQIGame\\Scene\\GhostGame\\GhostEnemyHpBarView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.hpImgCom = self.HpImg:GetComponent("Image")
	self.Canvas:GetComponent("Canvas").worldCamera = GhostGameModule.ghostGameScene.sceneCamera

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(ghostEnemyData)
	if ghostEnemyData.defaultBuff == -1 then
		return
	end

	local buffCfg = CfgGhostGameBuffTable[ghostEnemyData.defaultBuff]

	AssetUtil.LoadImage(self, buffCfg.Icon, self.buffImg:GetComponent("Image"))
	UGUIUtil.SetText(self.buffName, buffCfg.Name)
	self:Show()
end

function m:UpdateHpBar(curHp)
	self.hpImgCom.fillAmount = curHp / self.totalHp
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	self.hpImgCom = nil

	GameObject.Destroy(self.View)

	self.View = nil
	self = nil
end

return m
