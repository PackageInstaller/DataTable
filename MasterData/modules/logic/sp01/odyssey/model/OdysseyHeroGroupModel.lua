-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyHeroGroupModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyHeroGroupModel", package.seeall)

local OdysseyHeroGroupModel = class("OdysseyHeroGroupModel", BaseModel)

function OdysseyHeroGroupModel:onInit()
	self:reInit()
end

function OdysseyHeroGroupModel:reInit()
	self._formInfoList = {}
	self._formInfoDic = {}
	self._heroGroupInfoDic = {}
	self._curIndex = 1
end

function OdysseyHeroGroupModel:isPositionOpen(pos)
	return pos > 0 and pos <= OdysseyEnum.MaxHeroGroupCount
end

function OdysseyHeroGroupModel:updateFormInfo(info)
	local tempFormInfoDic = self._formInfoDic
	local tempHeroGroupInfoDic = self._heroGroupInfoDic

	if info ~= nil then
		local no = info.no
		local heroGroupInfo

		if tempFormInfoDic[no] == nil then
			tempFormInfoDic[no] = info
			heroGroupInfo = OdysseyHeroGroupMo.New()

			heroGroupInfo:init(info)

			tempHeroGroupInfoDic[info.no] = heroGroupInfo
		else
			tempFormInfoDic[no] = info
			heroGroupInfo = tempHeroGroupInfoDic[no]

			tempHeroGroupInfoDic[no]:init(info)
		end

		logNormal("奥德赛阵营 服务器返回 当前索引:" .. tostring(info.no))

		self._curIndex = info.no
	end

	tabletool.clear(self._formInfoList)

	for _, singleInfo in pairs(tempFormInfoDic) do
		table.insert(self._formInfoList, singleInfo)
	end

	OdysseyHeroGroupController.instance:dispatchEvent(OdysseyEvent.OnHeroGroupUpdate)
end

function OdysseyHeroGroupModel:getCurHeroGroup()
	return self._heroGroupInfoDic[self._curIndex]
end

function OdysseyHeroGroupModel:getSaveType()
	return self._saveType
end

function OdysseyHeroGroupModel:setSaveType(saveType)
	self._saveType = saveType
end

function OdysseyHeroGroupModel:getCommonGroupName(index)
	index = index or self._curIndex

	return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(index))
end

function OdysseyHeroGroupModel:canSwitchHeroGroupSelectIndex(index)
	if index == 0 then
		logError("无法切到玩法编队")

		return false
	end

	if self._curIndex == index then
		return false
	end

	logNormal("奥德赛阵营 本地设置 当前索引:" .. tostring(index))

	return true
end

function OdysseyHeroGroupModel:getCurFormInfo()
	return self._formInfoDic[self._curIndex]
end

function OdysseyHeroGroupModel:getCurIndex()
	return self._curIndex
end

function OdysseyHeroGroupModel:getHeroGroupByIndex(index)
	return self._heroGroupInfoDic[index]
end

function OdysseyHeroGroupModel:getFormByNoId(index)
	return self._formInfoDic[index]
end

function OdysseyHeroGroupModel:getBattleRoleNum()
	return OdysseyEnum.MaxHeroGroupCount
end

OdysseyHeroGroupModel.instance = OdysseyHeroGroupModel.New()

return OdysseyHeroGroupModel
