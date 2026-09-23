
local per = 10
local canRequire = true --可以继续请求（如果该次请求回来的数量不对，则不能再请求了）
local curIndex = 0

function Awake()
	layout = ComUtil.GetCom(vsv, "UIInfinite")
	layout:Init("UIs/Matrix/MatrixTradingRecordItem", LayoutCallBack, true)
end

function OnInit()
	UIUtil:AddTop2("MatrixTradingRecord", gameObject, function()view:Close()end, nil, {})
end 

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.Refresh(_data)
		if(index == #curDatas) then
			GetDatas()
		end
	end
end

function OnOpen()
	curDatas = {}
	GetDatas()
end

function GetDatas()
	if(canRequire) then
		BuildingProto:GetBuildOpLog(curIndex + 1, per, RefreshPanel)
	end
end

function RefreshPanel(proto)
	local infos = proto.infos or {}
	local len = #infos
	if(len ~= per) then
		canRequire = false
	end
	
	for i, v in ipairs(infos) do
		table.insert(curDatas, v)
	end
	
	curIndex = #curDatas
	
	if(#curDatas > 0) then
		CSAPI.SetGOActive(empty, false)
		layout:IEShowList(#curDatas)
	else
		CSAPI.SetGOActive(vsv, false)
		CSAPI.SetGOActive(empty, true)
	end
	local agree = proto.agree or 0
	CSAPI.SetText(txtAgree, agree.."")
end

