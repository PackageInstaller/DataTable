-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/model/MainuiModel.lua

module("logic.extensions.mainui.model.MainuiModel", package.seeall)

local MainuiModel = class("MainuiModel", BaseModel)

function MainuiModel:ctor()
	return
end

function MainuiModel:onInit()
	self:onReset()
end

function MainuiModel:onReset()
	self._objList = {}
end

function MainuiModel:getTopBarParams()
	return {
		{
			showAdd = true,
			id = GameEnum.GoldType.Coin
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Tili
		}
	}
end

function MainuiModel:setTopBarParams(obj, defaultDiamondAdd)
	self._objList = obj or self:getTopBarParams()

	if defaultDiamondAdd == nil or defaultDiamondAdd == true then
		for _, v in ipairs(self._objList) do
			local matType, matId, matNum = MaterialMgr.getMatParams(v.id)

			if v.id == GameEnum.GoldType.Diamond then
				v.showAdd = true
			elseif matType == MatType.ACTIVITY_ENERGY then
				v.showAdd = EnergyController.instance:isNeedBtnAdd(matId)
			end
		end
	end
end

function MainuiModel:getObjList()
	return self._objList
end

MainuiModel.instance = MainuiModel.New()

return MainuiModel
