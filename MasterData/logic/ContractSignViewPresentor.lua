-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSignViewPresentor.lua

module("logic.extensions.contract.view.ContractSignViewPresentor", package.seeall)

local ContractSignViewPresentor = class("ContractSignViewPresentor", ViewPresentor)

ContractSignViewPresentor.SignAnimPath = "effect/prefabs/ui/fx_ui_qiandingqiyue/qiandingqiyue_spine/qiandingqiyue-ui_p.prefab"
ContractSignViewPresentor.BgEffectPath = "fx_ui_qiandingqiyue/fx_ui_qiandingqiyue_tx01.prefab"

function ContractSignViewPresentor:ctor()
	ContractSignViewPresentor.super.ctor(self)
end

function ContractSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractSignViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractsignview.prefab",
		ContractSignViewPresentor.SignAnimPath
	}
end

function ContractSignViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(ContractSignViewPresentor.BgEffectPath)
	}
end

function ContractSignViewPresentor:buildViews()
	return {
		ContractSignView.New()
	}
end

return ContractSignViewPresentor
