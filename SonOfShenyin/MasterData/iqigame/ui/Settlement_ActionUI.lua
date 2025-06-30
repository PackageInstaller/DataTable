-- chunkname: @IQIGame\\UI\\Settlement_ActionUI.lua

local Settlement_ActionUI = {}

Settlement_ActionUI = Base:Extend("Settlement_ActionUI", "IQIGame.Onigao.UI.Settlement_ActionUI", Settlement_ActionUI)

local SettlementLevelViewClass = require("IQIGame/UI/SettlementUI/SettlementLevelView")
local SettlementRewardViewClass = require("IQIGame/UI/SettlementUI/settlementRewardView")

function Settlement_ActionUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function Settlement_ActionUI:InitDelegate()
	function self.delegateOnClickButtonClose()
		UIModule.CloseSelf(self)

		if self.closeCallBack then
			self.closeCallBack()

			self.closeCallBack = nil
		end
	end
end

function Settlement_ActionUI:InitComponent()
	self.levelView = SettlementLevelViewClass.New(self.settlementLevelView, self)
	self.rewardView = SettlementRewardViewClass.New(self.settlementRewardView, self)
end

function Settlement_ActionUI:OnAddListeners()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
end

function Settlement_ActionUI:OnRemoveListeners()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
end

function Settlement_ActionUI:OnOpen(userData)
	Time.timeScale = 1
	self.closeCallBack = userData.closeCallBack

	self:Refresh(userData)
end

function Settlement_ActionUI:OnClose(userData)
	return
end

function Settlement_ActionUI:GetPreloadAssetPaths()
	return nil
end

function Settlement_ActionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function Settlement_ActionUI:IsManualShowOnOpen(userData)
	return false
end

function Settlement_ActionUI:GetBGM(userData)
	return nil
end

function Settlement_ActionUI:OnPause()
	return
end

function Settlement_ActionUI:OnResume()
	return
end

function Settlement_ActionUI:OnCover()
	return
end

function Settlement_ActionUI:OnReveal()
	return
end

function Settlement_ActionUI:OnRefocus(userData)
	return
end

function Settlement_ActionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function Settlement_ActionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function Settlement_ActionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function Settlement_ActionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function Settlement_ActionUI:Refresh(data)
	if data.fightOverPOD.fightResult == Constant.FightResult.ATTACKER_WIN then
		LuaUtility.SetText(self.textTitle, CfgUtil.GetCfgTipsTextWithID(7000026))
	else
		LuaUtility.SetText(self.textTitle, CfgUtil.GetCfgTipsTextWithID(7000027))
	end

	local itemShowList, upExp = ItemModule.ExcludeExpItem_CountExp(data.fightOverPOD.awards)

	self.levelView:Refresh(upExp)

	itemShowList = ItemModule.ItemShowListSort(itemShowList)

	self.rewardView:Refresh(itemShowList)

	if self:HasHeroItem(itemShowList) then
		UIModule.Open(Constant.UIControllerName.GetPanelUI, Constant.UILayer.UI, {
			showType = 1,
			items = itemShowList
		})
	end

	local heroDataList = WarlockModule.GetWarlockList()
	local len = getTableLength(heroDataList)
	local showIndex = math.random(1, len)
	local index = 1

	for _, v in pairs(heroDataList) do
		if index == showIndex then
			LuaUtility.LoadImage(self, SkinModule.GetHeroCurrentSkinImgPath(v.cid, Constant.SkinImageType.HeroResourcesVerticalDraw), self.imageStandPaint:GetComponent("Image"), function()
				LuaUtility.SetImageNativeSizeWithGameObject(self.imageStandPaint)
				LuaUtility.SetImageRectTransformPivot(self.imageStandPaint:GetComponent("RectTransform"), self.imageStandPaint:GetComponent("Image"))
			end)

			break
		end

		index = index + 1
	end
end

function Settlement_ActionUI:HasHeroItem(itemShowList)
	for k, v in pairs(itemShowList) do
		if CfgItemTable[v.cid].ItemTypes == Constant.ItemType.Hero then
			return true
		end

		if v.srcId ~= 0 and CfgItemTable[v.srcId].ItemTypes == Constant.ItemType.Hero then
			return true
		end
	end

	return false
end

function Settlement_ActionUI:OnDestroy()
	self.levelView:OnDestroy()
	self.rewardView:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

return Settlement_ActionUI
