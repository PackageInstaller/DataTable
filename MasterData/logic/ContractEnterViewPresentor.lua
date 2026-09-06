-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractEnterViewPresentor.lua

module("logic.extensions.contract.view.ContractEnterViewPresentor", package.seeall)

local ContractEnterViewPresentor = class("ContractEnterViewPresentor", ViewPresentor)

ContractEnterViewPresentor.EffectPath = "fx_ui_zhaohuanshizhimen/fx_ui_zhaohuansizhimen.prefab"

function ContractEnterViewPresentor:ctor()
	ContractEnterViewPresentor.super.ctor(self)
end

function ContractEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractenterview.prefab"
	}
end

function ContractEnterViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(ContractEnterViewPresentor.EffectPath)
	}
end

function ContractEnterViewPresentor:buildViews()
	return {
		ContractEnterView.New()
	}
end

return ContractEnterViewPresentor
