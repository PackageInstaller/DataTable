function Awake()
	SetImg()
end

function OnEnable()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Bag_Update, Refresh)

	Refresh()
end

function OnDisable()
	eventMgr:ClearListener();
end


function SetImg()
	ResUtil.IconGoods:Load(img_diamon,ITEM_ID.DIAMOND.."",false,nil)
	ResUtil.IconGoods:Load(img_gold,ITEM_ID.GOLD.."",false,nil)
end

function Refresh()
	CSAPI.SetText(txt_gold, PlayerClient:GetGold() .. "")
	CSAPI.SetText(txt_gmax, "MAX: "..PlayerClient:GetGoldMax() .. "")
	CSAPI.SetText(txt_diamon, PlayerClient:GetDiamond() .. "")
end

--添加金币
function OnClickDAdd()
	JumpMgr:Jump(140002)
end

--添加钻石
function OnClickDAdd()
	JumpMgr:Jump(140001)
end 