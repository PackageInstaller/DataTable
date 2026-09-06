-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/config/MiMengLiConfig.lua

module("logic.extensions.mimengli.config.MiMengLiConfig", package.seeall)

local MiMengLiConfig = class("MiMengLiConfig", BaseConfig)

function MiMengLiConfig:getNames()
	return {
		"mi_meng_li_clg_creeps",
		"mi_meng_li_clg_tag_type",
		"mi_meng_li_clg_shop_goods",
		"mi_meng_li_clg_stage",
		"mi_meng_li_clg_creeps_master",
		"mi_meng_li_clg",
		"mi_meng_li_clg_tag_buff"
	}
end

function MiMengLiConfig:handleConfig(name, content)
	if name == "mi_meng_li_clg_creeps" then
		self._mi_meng_li_clg_creeps = content
	elseif name == "mi_meng_li_clg_tag_type" then
		self._mi_meng_li_clg_tag_type = content
	elseif name == "mi_meng_li_clg_shop_goods" then
		self._mi_meng_li_clg_shop_goods = content
	elseif name == "mi_meng_li_clg_stage" then
		self._mi_meng_li_clg_stage = content
	elseif name == "mi_meng_li_clg_creeps_master" then
		self._mi_meng_li_clg_creeps_master = content
	elseif name == "mi_meng_li_clg" then
		self._mi_meng_li_clg = content
	elseif name == "mi_meng_li_clg_tag_buff" then
		self._mi_meng_li_clg_tag_buff = content

		self:_initBuff()
	end
end

function MiMengLiConfig:getActivityCfgById(activityId)
	return self._mi_meng_li_clg[activityId]
end

function MiMengLiConfig:getStageCfgList(activityId)
	return self._mi_meng_li_clg_stage[activityId]
end

function MiMengLiConfig:getBuffTagCfgList(activityId)
	return self._mi_meng_li_clg_tag_type[activityId]
end

function MiMengLiConfig:getBuffTagCfgById(activityId, tagType)
	if self._mi_meng_li_clg_tag_type[activityId] then
		return self._mi_meng_li_clg_tag_type[activityId][tagType]
	end
end

function MiMengLiConfig:getShopGoodsCfgById(activityId, shopId)
	if self._mi_meng_li_clg_shop_goods[activityId] then
		return self._mi_meng_li_clg_shop_goods[activityId][shopId]
	end
end

function MiMengLiConfig:getShopGoodsAllCfgList(activityId)
	return self._mi_meng_li_clg_shop_goods[activityId]
end

function MiMengLiConfig:getStageCfgById(activityId, stageId)
	if self._mi_meng_li_clg_stage[activityId] then
		return self._mi_meng_li_clg_stage[activityId][stageId]
	end
end

function MiMengLiConfig:_initBuff()
	self._mi_meng_li_clg_tag_buff_list = {}

	for k, actCfg in pairs(self._mi_meng_li_clg_tag_buff) do
		for k2, tagCfg in pairs(actCfg) do
			local list = {}

			for k3, v in pairs(tagCfg) do
				table.insert(list, v)
			end

			ArraySort.sortOn(list, "tagNum", ArraySort.NUMERIC)

			self._mi_meng_li_clg_tag_buff_list[k] = self._mi_meng_li_clg_tag_buff_list[k] or {}
			self._mi_meng_li_clg_tag_buff_list[k][k2] = list
		end
	end
end

function MiMengLiConfig:getCloseBuffCfgById(activityId, tagType, curCount)
	if self._mi_meng_li_clg_tag_buff_list[activityId] then
		local list = self._mi_meng_li_clg_tag_buff_list[activityId][tagType]

		if list then
			for k, v in ipairs(list) do
				if curCount <= v.tagNum then
					return v
				end
			end

			return list[#list]
		end
	end
end

function MiMengLiConfig:getBuffCfgByTag(activityId, tagType)
	if self._mi_meng_li_clg_tag_buff_list[activityId] then
		return self._mi_meng_li_clg_tag_buff_list[activityId][tagType]
	end
end

function MiMengLiConfig:getMonsterCfgById(creepsMasterId)
	return self._mi_meng_li_clg_creeps_master[creepsMasterId]
end

function MiMengLiConfig:getCreepsById(creepsMasterId)
	return self._mi_meng_li_clg_creeps[creepsMasterId]
end

MiMengLiConfig.instance = MiMengLiConfig.New()

return MiMengLiConfig
