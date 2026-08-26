-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/model/VersionActivity2_3NewCultivationGiftRewardListModel.lua

local VersionActivity2_3NewCultivationGiftRewardListModel = class("VersionActivity2_3NewCultivationGiftRewardListModel", ListScrollModel)

function VersionActivity2_3NewCultivationGiftRewardListModel:setRewardList(infos)
	local list = {}

	if not string.nilorempty(infos) then
		local datas = string.split(infos, "|")

		if datas and #datas > 0 then
			for _, data in ipairs(datas) do
				local mo = {}
				local reward = string.splitToNumber(data, "#")

				mo.type = reward[1]
				mo.id = reward[2]
				mo.quantity = reward[3]

				table.insert(list, mo)
			end
		end
	end

	self:setList(list)
end

VersionActivity2_3NewCultivationGiftRewardListModel.instance = VersionActivity2_3NewCultivationGiftRewardListModel.New()

return VersionActivity2_3NewCultivationGiftRewardListModel
