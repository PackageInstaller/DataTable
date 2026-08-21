local InteractiveType = {}
InteractiveType.Gift = { type = 1, text = 870 } --送礼物
InteractiveType.Greet = { type = 2, text = 871 } --打招呼（邀请少女过来）
InteractiveType.ChangeFurniture = { type = 3, text = 914 } --更换家具
InteractiveType.Suger = { type = 4, templateId = 215002, text = 915, ui = "GeneralBook" } --查看糖罐
InteractiveType.Book = { type = 4, templateId = 215001, text = 916, ui = "GeneralBook" } --查看书
InteractiveType.PlantFurniture = { type = 5, text = 917 } --植物家具
InteractiveType.PhotoWall = { type = 6, text = 5173 }
InteractiveType.BookCase = { type = 7, text = 5172 }
InteractiveType.ChangePosterWall={ type = 8, text = "查看海报" }
InteractiveType.SeePhotoWall={ type = 9, text = "查看照片墙" }
InteractiveType.ChangePhotoWall={ type = 10, text = "更换照片" }
InteractiveType.ChangeGroupPhoto={ type = 11, text = "查看合影墙" }

return InteractiveType
