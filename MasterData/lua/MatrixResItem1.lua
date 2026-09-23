
function Awake()
	tween = ComUtil.GetCom(txtNum, "ActionBase")
end

function SetClickCB(_cb)
	cb = _cb
end


--{id, num}
function Refresh(_data)
	data = _data
	--icon
	-- local iconName = Cfgs.ItemInfo:GetByID(data[1]).icon
	-- SetIcon(iconName)
	--item
	if(item == nil) then
		local _num = BagMgr:GetCount(data[1])
		local reward = {id = data[1], num = _num, type = RandRewardType.ITEM}
		item = ResUtil:CreateRandRewardGrid(reward, childParent.transform)
		item.SetCount()
		--item.SetClickCB(nil)
	end
	
	--num 
	local num = data[2]
	--CSAPI.SetText(txtNum, num .. "")
	tween.targetNum = num  
	tween:Play()
end

function SetIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil)
	if(iconName) then
		ResUtil.IconGoods:Load(icon, iconName)
	end
end


function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	childParent = nil;
	txtNum = nil;
	view = nil;
end
----#End#----
