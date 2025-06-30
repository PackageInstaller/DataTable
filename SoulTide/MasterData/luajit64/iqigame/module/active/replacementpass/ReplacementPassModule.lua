-- chunkname: @IQIGame\\Module\\Active\\ReplacementPass\\ReplacementPassModule.lua

local m = {}

function m.Reload()
	return
end

function m.CheckReplacementPassRedPoint()
	return false
end

function m:GetDataList()
	local tab = {}

	for i, v in pairsCfg(CfgPassRepurchaseGiftTable) do
		local residueTimes = MallModule.GetResidueBuyTimes(v.MallId)

		if residueTimes > 0 then
			local errorCode = MallModule.CheckCanBuyMall(v.MallId, 1)

			if errorCode == 0 then
				table.insert(tab, v)
			else
				log("回购通行证 条件检测失败 errorCode = " .. errorCode)
			end
		end
	end

	return tab
end

function m.Shutdown()
	return
end

ReplacementPassModule = m
