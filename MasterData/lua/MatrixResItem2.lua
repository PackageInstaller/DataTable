--  {id, ratioStr, count, countMax}
function Awake()
	outlineBar = ComUtil.GetCom(bar, "OutlineBar")
end

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data)
	data = _data
	--资源产出
	CSAPI.SetText(txtStr11, string.format("%s", data[2]))
	--num slier 
	CSAPI.SetText(txtStr3, string.format("%s<color=#929296>/%s</color>", data[3], data[4]))
	outlineBar:SetProgress(data[3] / data[4])
	--item
	if(item == nil) then
		local _num = BagMgr:GetCount(data[1])
		local reward = {id = data[1], num = _num, type = RandRewardType.ITEM}
		item = ResUtil:CreateRandRewardGrid(reward, childParent.transform)
		item.SetCount()
		
		-- CSAPI.SetRTSize(item.gameObject, 176, 176)
		-- item.transform.offsetMin = UnityEngine.Vector2(0.5, 0.5)
		-- item.transform.offsetMax = UnityEngine.Vector2(0.5, 0.5)
		--CSAPI.SetAnchor(item.gameObject, 0, 0)
	end
end

function OnClickGet()
	if(cb) then
		cb(data[1])
	end
end
