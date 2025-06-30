local UIBlackView = BaseClass("UIBlackView", UIBaseView)
local base = UIBaseView
local this = UIBlackView

function this.OnCreate(self)
	base.OnCreate(self)
	self.up = self.rc:GetObject("Up"):GetComponent("RectTransform")
	self.down = self.rc:GetObject("Down"):GetComponent("RectTransform")
	self.left = self.rc:GetObject("Left"):GetComponent("RectTransform")
	self.right = self.rc:GetObject("Right"):GetComponent("RectTransform")
	self.zhuanChang = self.rc:GetObject("ZhuanChang")
	self.zhuanChang1 = self.rc:GetObject("ZhuanChang1")
	self.zhuanChang.gameObject:SetActive(false)
	self.zhuanChang1.gameObject:SetActive(false)
	local width = UIManager:GetInstance().maxWidth
	local height = UIManager:GetInstance().maxHeight
	self.up.transform:DOLocalMoveY((height + self.up.sizeDelta.y) / 2 - 1, 0)
	self.down.transform:DOLocalMoveY(-(height + self.down.sizeDelta.y) / 2 + 1, 0)
	self.left.transform:DOLocalMoveX(-(width + self.left.sizeDelta.x) / 2 + 1, 0)
	self.right.transform:DOLocalMoveX((width + self.right.sizeDelta.x) / 2 - 1, 0)
	--self.up.transform:DOSizeDelta(Vector2.New(width, height), 0)
	--self.down.transform:DOSizeDelta(Vector2.New(width, height), 0)
	--self.left.transform:DOSizeDelta(Vector2.New(width, height), 0)
	--self.right.transform:DOSizeDelta(Vector2.New(width, height), 0)
end

function this.OnEnable(self)
	base.OnEnable(self)
end

return UIBlackView