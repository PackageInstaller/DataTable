--SignInfDayInfo
local items = nil
local dayText = nil

function Awake()
	dayText = ComUtil.GetCom(txtDay,"Text")
end

function Refresh(_data, _isShowNextDay)
	isShowNextDay = _isShowNextDay
	data = _data
	id = data.id
	if(not id) then
		return --空数据
	end
	
	index = data:GetIndex() or 1 --天
	isDone = data:CheckIsDone() --已签
	isCurDay = data:GetIsCurDay() --是否是当天
	isNextDay = data:GetIsNextDay() and isShowNextDay --是否是下一天
	isSpecial = data:GetSpecial() ~= nil
		
	SetNode()
	SetItems()
end

function SetNode()
	CSAPI.SetGOActive(nol,not isSpecial)
	CSAPI.SetGOActive(spec, isSpecial)

	CSAPI.SetGOActive(nextImg, isNextDay)
	if isNextDay then
		CSAPI.SetAnchor(nextImg,isSpecial and -107 or -99,isSpecial and 107 or 75)
	end

	CSAPI.SetGOActive(get, isDone)
	CSAPI.LoadImg(get,"UIs/SignInContinue7/img_04_" .. (isSpecial and "03" or "04") .. ".png",true,nil,true)

	SetRed(isCurDay and not isDone)

	CSAPI.SetAnchor(txtDay,isSpecial and -45 or -41,isSpecial and 206 or 165)
	dayText.fontSize = isSpecial and 95 or 86
	dayText.text = index < 10 and "0" .. index or index .. ""

	CSAPI.SetTextColorByCode(txtDay,isSpecial and "ff962b" or "a296a0")
end

function SetRed(b)
	CSAPI.SetAnchor(redParent,isSpecial and 98 or 94,isSpecial and 234 or 194)
	UIUtil:SetRedPoint(redParent,b)
end

function SetItems()
	local rewards = data:GetRewards() or {}
	items = items or {}
	ItemUtil.AddItems("SignInContinue7/SignInGiftItem2",items,rewards,grid,nil,1,{isSpecial = isSpecial})
	local scale = isSpecial and 1 or 0.92
	CSAPI.SetScale(grid,scale,scale,scale)
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
	bg = nil;
	node = nil;
	itemParent = nil;
	icon = nil;
	doneImg = nil;
	num1 = nil;
	num2 = nil;
	view = nil;
end
----#End#----
