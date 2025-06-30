-- chunkname: @IQIGame\\Module\\GmOrder\\GmOrderModule.lua

GmOrderModule = {
	GmOrderCfgData = {}
}

function GmOrderModule.Reload()
	GmOrderModule.GetAllGmOrderData()
end

function GmOrderModule.GetGmOrderCfg(index)
	return CfgGmOrderTable[index]
end

function GmOrderModule.GetAllGmOrderData()
	for k, v in pairsCfg(CfgGmOrderTable) do
		table.insert(GmOrderModule.GmOrderCfgData, v)
	end
end
