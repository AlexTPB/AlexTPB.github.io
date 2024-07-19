local Library = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local alreadyOnDefaultPage = false

function Library:Drag(gui)
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	gui.Bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	gui.Bar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function Library:Create(Name, Icon)
	assert(typeof(Name) == "string", "Expected String, got ".. tostring(typeof(Name)))
	assert(typeof(Icon) == "string", "Expected ImageID String, got ".. tostring(typeof(Icon)))

	local xWindow = {}
	local BLOXUI = Instance.new("ScreenGui")
	local Window = Instance.new("Frame")
	local Bar = Instance.new("Frame")
	local Bar_WindowIcon = Instance.new("ImageLabel")
	local Bar_UIPadding = Instance.new("UIPadding")
	local Bar_UIListLayout = Instance.new("UIListLayout")
	local Bar_WindowName = Instance.new("TextLabel")
	local Options = Instance.new("Folder")
	local Close = Instance.new("TextButton")
	local Frame = Instance.new("Frame")
	local Frame_2 = Instance.new("Frame")
	local ShadedPart = Instance.new("Frame")
	local Tabs = Instance.new("ScrollingFrame")
	local Tabs_UIListLayout = Instance.new("UIListLayout")
	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	local Home_Label = Instance.new("TextLabel")
	local Home_Icon = Instance.new("ImageLabel")
	local Search = Instance.new("Frame")
	local SearchBox = Instance.new("TextBox")
	local SearchIcon = Instance.new("Folder")
	local Search_UIStroke = Instance.new("UIStroke")
	local ImageLabel = Instance.new("ImageLabel")
	local BlackPart = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local BlackPart_UIPadding = Instance.new("UIPadding")
	local Pages = Instance.new("Folder")
	local BlackPart_UIListLayout = Instance.new("UIListLayout")
	local NotificationSound = Instance.new("Sound")
	local Shadow = Instance.new("ImageLabel")

	BLOXUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	BLOXUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Window.Name = "Window"
	Window.Parent = BLOXUI
	Window.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Window.BackgroundTransparency = 1.000
	Window.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Window.BorderSizePixel = 0
	Window.Position = UDim2.new(0.042005457, 0, 0.221662477, 0)
	Window.Size = UDim2.new(0.471940666, 0, 0.553806067, 0)

	Bar.Name = "Bar"
	Bar.Parent = Window
	Bar.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Bar.BorderSizePixel = 0
	Bar.Size = UDim2.new(1, 0, 0.0761787146, 0)

	Bar_WindowIcon.Name = "Bar_WindowIcon"
	Bar_WindowIcon.Parent = Bar
	Bar_WindowIcon.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	Bar_WindowIcon.BackgroundTransparency = 1.000
	Bar_WindowIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Bar_WindowIcon.BorderSizePixel = 0
	Bar_WindowIcon.Position = UDim2.new(7.2798878e-09, 0, 0.0781018585, 0)
	Bar_WindowIcon.Size = UDim2.new(0, 23, 0, 23)
	Bar_WindowIcon.ZIndex = 2
	Bar_WindowIcon.Image = "rbxassetid://".. Icon

	Bar_UIPadding.Name = "Bar_UIPadding"
	Bar_UIPadding.Parent = Bar
	Bar_UIPadding.PaddingLeft = UDim.new(0, 3)

	Bar_UIListLayout.Name = "Bar_UIListLayout"
	Bar_UIListLayout.Parent = Bar
	Bar_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	Bar_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	Bar_UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	Bar_UIListLayout.Padding = UDim.new(0, 6)

	Bar_WindowName.Name = "Bar_WindowName"
	Bar_WindowName.Parent = Bar
	Bar_WindowName.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	Bar_WindowName.BackgroundTransparency = 1.000
	Bar_WindowName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Bar_WindowName.BorderSizePixel = 0
	Bar_WindowName.Position = UDim2.new(0.0488211438, 0, 0.152310744, 0)
	Bar_WindowName.Size = UDim2.new(0.820462465, 0, 0.59674865, 0)
	Bar_WindowName.ZIndex = 2
	Bar_WindowName.Font = Enum.Font.Gotham
	Bar_WindowName.Text = Name 
	Bar_WindowName.TextColor3 = Color3.fromRGB(255, 255, 255)
	Bar_WindowName.TextScaled = true
	Bar_WindowName.TextSize = 14.000
	Bar_WindowName.TextWrapped = true
	Bar_WindowName.TextXAlignment = Enum.TextXAlignment.Left

	Options.Name = "Options"
	Options.Parent = Bar

	Close.Name = "Close"
	Close.Parent = Options
	Close.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	Close.BackgroundTransparency = 1.000
	Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(0.91636622, 0, 0.152311206, 0)
	Close.Size = UDim2.new(0.0775449201, 0, 0.695377707, 0)
	Close.ZIndex = 5
	Close.Font = Enum.Font.Gotham
	Close.Text = "X"
	Close.TextColor3 = Color3.fromRGB(255, 255, 255)
	Close.TextScaled = true
	Close.TextSize = 14.000
	Close.TextWrapped = true

	Frame.Parent = Options
	Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.34893015, 0, -1.38399298e-06, 0)
	Frame.Size = UDim2.new(0, 386, 0, 37)

	Frame_2.Parent = Window
	Frame_2.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
	Frame_2.BackgroundTransparency = 1.000
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Position = UDim2.new(0, 0, 0.0761787519, 0)
	Frame_2.Size = UDim2.new(1, 0, 0.920473456, 0)

	ShadedPart.Name = "ShadedPart"
	ShadedPart.Parent = Frame_2
	ShadedPart.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	ShadedPart.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ShadedPart.BorderSizePixel = 0
	ShadedPart.Position = UDim2.new(0, 0, 3.81799197e-08, 0)
	ShadedPart.Size = UDim2.new(0.352201909, 0, 1.00208831, 0)

	Tabs.Name = "Tabs"
	Tabs.Parent = ShadedPart
	Tabs.Active = true
	Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tabs.BackgroundTransparency = 1.000
	Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tabs.BorderSizePixel = 0
	Tabs.Position = UDim2.new(6.64951827e-08, 0, 0.224572122, 0)
	Tabs.Size = UDim2.new(0.999999881, 0, 0.754227161, 0)
	Tabs.CanvasSize = UDim2.new(0, 0, 0, 0)
	Tabs.ScrollBarThickness = 3

	Tabs_UIListLayout.Name = "Tabs_UIListLayout"
	Tabs_UIListLayout.Parent = Tabs
	Tabs_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	Tabs_UIListLayout.Padding = UDim.new(0, 6)

	Home_Label.Name = "Home_Label"
	Home_Label.Parent = ShadedPart
	Home_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Home_Label.BackgroundTransparency = 1.000
	Home_Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Home_Label.BorderSizePixel = 0
	Home_Label.Position = UDim2.new(0.198312238, 0, 0.0248344392, 0)
	Home_Label.Size = UDim2.new(0.426160306, 0, 0.0483748205, 0)
	Home_Label.Font = Enum.Font.Gotham
	Home_Label.Text = "Home"
	Home_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Home_Label.TextScaled = true
	Home_Label.TextSize = 14.000
	Home_Label.TextWrapped = true
	Home_Label.TextXAlignment = Enum.TextXAlignment.Left

	Home_Icon.Name = "Home_Icon"
	Home_Icon.Parent = ShadedPart
	Home_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Home_Icon.BackgroundTransparency = 1.000
	Home_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Home_Icon.BorderSizePixel = 0
	Home_Icon.Position = UDim2.new(0.0611322001, 0, 0.0223319642, 0)
	Home_Icon.Size = UDim2.new(0.0896415785, 0, 0.052551534, 0)
	Home_Icon.Image = "rbxassetid://12755723208"

	Search.Name = "Search"
	Search.Parent = ShadedPart
	Search.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Search.BorderSizePixel = 0
	Search.Position = UDim2.new(0.0882145837, 0, 0.12129496, 0)
	Search.Size = UDim2.new(0.824937284, 0, 0.06064751, 0)
	Search.ZIndex = -1

	SearchBox.Name = "SearchBox"
	SearchBox.Parent = Search
	SearchBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	SearchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchBox.BorderSizePixel = 0
	SearchBox.Position = UDim2.new(0.0413904488, 0, 0.0399991646, 0)
	SearchBox.Size = UDim2.new(0.802704453, 0, 0.880000174, 0)
	SearchBox.ClearTextOnFocus = false
	SearchBox.Font = Enum.Font.SourceSans
	SearchBox.PlaceholderText = "Find a Tab"
	SearchBox.Text = ""
	SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.TextScaled = true
	SearchBox.TextSize = 14.000
	SearchBox.TextWrapped = true
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	SearchIcon.Name = "SearchIcon"
	SearchIcon.Parent = Search

	Search_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
	Search_UIStroke.Thickness = 3
	Search_UIStroke.Color = Color3.fromRGB(75, 75, 75)
	Search_UIStroke.Parent = Search

	ImageLabel.Parent = SearchIcon
	ImageLabel.Active = true
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.844094872, 0, 0.0471144542, 0)
	ImageLabel.Size = UDim2.new(0, 21, 0, 21)
	ImageLabel.Image = "rbxassetid://5107220207"

	BlackPart.Name = "BlackPart"
	BlackPart.Parent = Frame_2
	BlackPart.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	BlackPart.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BlackPart.BorderSizePixel = 0
	BlackPart.Position = UDim2.new(0.352201879, 0, -0.0126054445, 0)
	BlackPart.Size = UDim2.new(0.649, 0, 1.01469386, 0)
	BlackPart.ZIndex = -1

	Title.Name = "Title"
	Title.Parent = BlackPart
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(-0.0584938899, 0, -0.00667255605, 0)
	Title.Size = UDim2.new(0.659689605, 0, 0.0711577684, 0)
	Title.Font = Enum.Font.Gotham
	Title.Text = "Tab"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	BlackPart_UIPadding.Name = "BlackPart_UIPadding"
	BlackPart_UIPadding.Parent = BlackPart
	BlackPart_UIPadding.PaddingLeft = UDim.new(0, 14)
	BlackPart_UIPadding.PaddingTop = UDim.new(0, 8)

	Pages.Name = "Pages"
	Pages.Parent = BlackPart

	BlackPart_UIListLayout.Name = "BlackPart_UIListLayout"
	BlackPart_UIListLayout.Parent = BlackPart
	BlackPart_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	NotificationSound.SoundId = "rbxassetid://2389339814"
	NotificationSound.Parent = BLOXUI

	Shadow.Name = "Shadow"
	Shadow.Parent = Window
	Shadow.AnchorPoint = Vector2.new(0.03, 0.04)
	Shadow.BackgroundTransparency = 1.000
	Shadow.BorderSizePixel = 0
	Shadow.Position = UDim2.new(0, 0, 0, 0)
	Shadow.Size = UDim2.new(1.0671072, 0, 1.09259927, 0)
	Shadow.ZIndex = -9999
	Shadow.Image = "rbxassetid://6150493168"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.500
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(100, 100, 100, 100)
	Shadow.SliceScale = 0.400

	function Library:Notification(Args)
		assert(typeof(Args["Title"]) == "string", "Expected String, got ".. tostring(typeof(Args["Title"])))
		assert(typeof(Args["Description"]) == "string", "Expected String, got ".. tostring(typeof(Args["Description"])))

		repeat task.wait() until not BLOXUI:FindFirstChild("Notification")

		local xNotification = {}

		local Notification = Instance.new("Frame")
		local Notification_Bar = Instance.new("Frame")
		local Notification_Bar_Icon = Instance.new("ImageLabel")
		local Notification_Bar_UIPadding = Instance.new("UIPadding")
		local Notification_Bar_UIListLayout = Instance.new("UIListLayout")
		local Notification_Bar_Name = Instance.new("TextLabel")
		local Notification_Options = Instance.new("Folder")
		local Notification_Close = Instance.new("TextButton")
		local Details = Instance.new("Folder")
		local Details_Title = Instance.new("TextLabel")
		local Details_Description = Instance.new("TextLabel")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

		Notification.Name = "Notification"
		Notification.Parent = BLOXUI
		Notification.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
		Notification.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notification.BorderSizePixel = 0
		Notification.Position = UDim2.new(1.05, 0, 0.832493722, 0)
		Notification.Size = UDim2.new(0.185185179, 0, 0.130982369, 0)
		Notification.Visible = true

		Notification_Bar.Name = "Notification_Bar"
		Notification_Bar.Parent = Notification
		Notification_Bar.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		Notification_Bar.BackgroundTransparency = 1.000
		Notification_Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notification_Bar.BorderSizePixel = 0
		Notification_Bar.Size = UDim2.new(1.00000024, 0, 0.276648253, 0)

		Notification_Bar_Icon.Name = "Notification_Bar_Icon"
		Notification_Bar_Icon.Parent = Notification_Bar
		Notification_Bar_Icon.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		Notification_Bar_Icon.BackgroundTransparency = 1.000
		Notification_Bar_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notification_Bar_Icon.BorderSizePixel = 0
		Notification_Bar_Icon.Position = UDim2.new(0, 0, -0.0662017316, 0)
		Notification_Bar_Icon.Size = UDim2.new(0.0923317671, 0, 0.868917882, 0)
		Notification_Bar_Icon.Image = Bar_WindowIcon.Image

		Notification_Bar_UIPadding.Name = "Notification_Bar_UIPadding"
		Notification_Bar_UIPadding.Parent = Notification_Bar
		Notification_Bar_UIPadding.PaddingLeft = UDim.new(0, 6)
		Notification_Bar_UIPadding.PaddingRight = UDim.new(0, 8)
		Notification_Bar_UIPadding.PaddingTop = UDim.new(0, 6)

		Notification_Bar_UIListLayout.Name = "Notification_Bar_UIListLayout"
		Notification_Bar_UIListLayout.Parent = Notification_Bar
		Notification_Bar_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		Notification_Bar_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		Notification_Bar_UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		Notification_Bar_UIListLayout.Padding = UDim.new(0, 6)

		Notification_Bar_Name.Name = "Notification_Bar_Name"
		Notification_Bar_Name.Parent = Notification_Bar
		Notification_Bar_Name.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		Notification_Bar_Name.BackgroundTransparency = 1.000
		Notification_Bar_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notification_Bar_Name.BorderSizePixel = 0
		Notification_Bar_Name.Position = UDim2.new(0.115806296, 0, 0.122429922, 0)
		Notification_Bar_Name.Size = UDim2.new(0.585593462, 0, 0.755141556, 0)
		Notification_Bar_Name.Font = Enum.Font.Gotham
		Notification_Bar_Name.Text = Bar_WindowName.Text
		Notification_Bar_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
		Notification_Bar_Name.TextScaled = true
		Notification_Bar_Name.TextSize = 14.000
		Notification_Bar_Name.TextWrapped = true
		Notification_Bar_Name.TextXAlignment = Enum.TextXAlignment.Left

		Notification_Options.Name = "Notification_Options"
		Notification_Options.Parent = Notification_Bar

		Notification_Close.Name = "Notification_Close"
		Notification_Close.Parent = Notification_Options
		Notification_Close.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		Notification_Close.BackgroundTransparency = 1.000
		Notification_Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notification_Close.BorderSizePixel = 0
		Notification_Close.Position = UDim2.new(0.889081359, 0, 0.0517252125, 0)
		Notification_Close.Size = UDim2.new(0.0992386565, 0, 0.882734597, 0)
		Notification_Close.Font = Enum.Font.Gotham
		Notification_Close.Text = "X"
		Notification_Close.TextColor3 = Color3.fromRGB(255, 255, 255)
		Notification_Close.TextScaled = true
		Notification_Close.TextSize = 14.000
		Notification_Close.TextWrapped = true

		Details.Name = "Details"
		Details.Parent = Notification

		Details_Title.Name = "Details_Title"
		Details_Title.Parent = Details
		Details_Title.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		Details_Title.BackgroundTransparency = 1.000
		Details_Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Details_Title.BorderSizePixel = 0
		Details_Title.Position = UDim2.new(0.074929744, 0, 0.37079972, 0)
		Details_Title.Size = UDim2.new(0.618584633, 0, 0.224999994, 0)
		Details_Title.Font = Enum.Font.Gotham
		Details_Title.Text = Args["Title"]
		Details_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Details_Title.TextScaled = true
		Details_Title.TextSize = 14.000
		Details_Title.TextWrapped = true
		Details_Title.TextXAlignment = Enum.TextXAlignment.Left

		Details_Description.Name = "Details_Description"
		Details_Description.Parent = Details
		Details_Description.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		Details_Description.BackgroundTransparency = 1.000
		Details_Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Details_Description.BorderSizePixel = 0
		Details_Description.Position = UDim2.new(0.074929744, 0, 0.601568937, 0)
		Details_Description.Size = UDim2.new(0.863029063, 0, 0.291117728, 0)
		Details_Description.Font = Enum.Font.Gotham
		Details_Description.Text = Args["Description"]
		Details_Description.TextColor3 = Color3.fromRGB(212, 212, 212)
		Details_Description.TextScaled = true
		Details_Description.TextSize = 14.000
		Details_Description.TextWrapped = true
		Details_Description.TextXAlignment = Enum.TextXAlignment.Left

		UIAspectRatioConstraint.Parent = Notification
		UIAspectRatioConstraint.AspectRatio = 2.163

		TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.fromScale(0.82, Notification.Position.Y.Scale)}):Play()
		NotificationSound:Play()

		function xNotification:Close()
			if Notification.Parent ~= nil then
				local out = TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.fromScale(1.05, Notification.Position.Y.Scale)})
				out:Play()

				out.Completed:Once(function()
					Notification.Visible = false

					Notification:Destroy()
				end)
			end
		end

		task.delay(3, function()
			xNotification:Close()
		end)

		Notification_Close.Activated:Once(function()
			xNotification:Close()
		end)

		return xNotification
	end

	function xWindow:Tab(Name, Icon)
		assert(typeof(Name) == "string", "Expected String, got ".. tostring(typeof(Name)))
		assert(typeof(Icon) == "string", "Expected ImageID String, got ".. tostring(typeof(Icon)))

		local xTab = {}
		local Page = Instance.new("ScrollingFrame")
		local Page_UIPadding = Instance.new("UIPadding")
		local Page_UIListLayout = Instance.new("UIListLayout")
		local Tab = Instance.new("ImageButton")
		local Tab_UIListLayout = Instance.new("UIListLayout")
		local Tab_Icon = Instance.new("ImageLabel")
		local Tab_Name = Instance.new("TextLabel")
		local Tab_Selected = Instance.new("Frame")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

		Page.Name = Name.. "_Page"
		Page.Parent = Pages
		Page.Active = true
		Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Page.BackgroundTransparency = 1.000
		Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Page.BorderSizePixel = 0
		Page.Position = UDim2.new(-0.0877408385, 0, 0.0787285119, 0)
		Page.Size = UDim2.new(1.07466042, 0, 0.921220541, 0)
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.ScrollBarThickness = 3
		Page.Visible = false

		Page_UIPadding.Name = "Page_UIPadding"
		Page_UIPadding.Parent = Page
		Page_UIPadding.PaddingLeft = UDim.new(0, 43)
		Page_UIPadding.PaddingTop = UDim.new(0, 12)

		Page_UIListLayout.Name = "Page_UIListLayout"
		Page_UIListLayout.Parent = Page
		Page_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		Page_UIListLayout.Padding = UDim.new(0, 10)

		Tab.Name = "Tab"
		Tab.Parent = Tabs
		Tab.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.BorderSizePixel = 0
		Tab.Position = UDim2.new(3.62844439e-08, 0, 0, 0)
		Tab.Size = UDim2.new(0, 210, 0, 32)
		Tab.AutoButtonColor = false
		Tab.ImageTransparency = 1.000

		Tab_UIListLayout.Name = "Tab_UIListLayout"
		Tab_UIListLayout.Parent = Tab
		Tab_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		Tab_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		Tab_UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		Tab_UIListLayout.Padding = UDim.new(0.100000001, 0)

		Tab_Icon.Name = "Tab_Icon"
		Tab_Icon.Parent = Tab
		Tab_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab_Icon.BackgroundTransparency = 1.000
		Tab_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab_Icon.BorderSizePixel = 0
		Tab_Icon.Position = UDim2.new(0.00428146916, 0, 0.172511861, 0)
		Tab_Icon.Size = UDim2.new(0, 22, 0, 22)
		Tab_Icon.Image = "rbxassetid://".. Icon

		Tab_Name.Name = "Tab_Name"
		Tab_Name.Parent = Tab
		Tab_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab_Name.BackgroundTransparency = 1.000
		Tab_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab_Name.BorderSizePixel = 0
		Tab_Name.Position = UDim2.new(0.317570835, 0, 0.21658802, 0)
		Tab_Name.Size = UDim2.new(0.680753589, 0, 0.627161741, 0)
		Tab_Name.Font = Enum.Font.Gotham
		Tab_Name.Text = Name
		Tab_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
		Tab_Name.TextScaled = true
		Tab_Name.TextSize = 14.000
		Tab_Name.TextWrapped = true
		Tab_Name.TextXAlignment = Enum.TextXAlignment.Left

		Tab_Selected.Name = "Tab_Selected"
		Tab_Selected.Parent = Tab
		Tab_Selected.BackgroundColor3 = Color3.fromRGB(124, 124, 124)
		Tab_Selected.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab_Selected.BorderSizePixel = 0
		Tab_Selected.LayoutOrder = -1
		Tab_Selected.Position = UDim2.new(0, 0, 0.119150795, 0)
		Tab_Selected.Size = UDim2.new(0.0235536862, 0, 0.664115191, 0)
		Tab_Selected.BackgroundTransparency = 1

		UIAspectRatioConstraint.Parent = Tab_Selected
		UIAspectRatioConstraint.AspectRatio = 0.261

		Tab.Activated:Connect(function()
			print("Selected Tab: ".. Name)

			BlackPart_UIPadding.PaddingLeft = UDim.new(0, 24)
			TweenService:Create(BlackPart_UIPadding, TweenInfo.new(0.2), {PaddingLeft = UDim.new(0, 14)}):Play()

			Title.Text = Name
			Title.Visible = true
			for _, ExistingPage in Pages:GetChildren() do
				if string.match(ExistingPage.Name, "_Page") then
					ExistingPage.Visible = false
				end
			end
			for _, ExistingSelection in Tabs:GetDescendants() do
				if ExistingSelection:IsA("Frame") and ExistingSelection.Name == "Tab_Selected" then
					ExistingSelection.BackgroundTransparency = 1
				end
			end
			Tab_Selected.BackgroundTransparency = 0
			Page.Visible = true
		end)

		function xTab:Section(Name)
			assert(typeof(Name) == "string", "Expected String, got ".. tostring(typeof(Name)))

			local xSection = {}

			local Section = Instance.new("TextLabel")

			Section.Name = "Section"
			Section.Parent = Page
			Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Section.BackgroundTransparency = 1.000
			Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.BorderSizePixel = 0
			Section.Position = UDim2.new(-0.0333560109, 0, 0.0258045401, 0)
			Section.Size = UDim2.new(0, 181, 0, 25)
			Section.Font = Enum.Font.GothamMedium
			Section.Text = Name
			Section.TextColor3 = Color3.fromRGB(255, 255, 255)
			Section.TextScaled = true
			Section.TextWrapped = true
			Section.TextXAlignment = Enum.TextXAlignment.Left

			function xSection:Button(Name, Function): Frame
				assert(typeof(Name) == "string", "Expected String, got ".. tostring(typeof(Name)))
				assert(typeof(Function) == "function", "Expected Function, got ".. tostring(typeof(Function)))

				Page.CanvasSize = UDim2.new(0, 0, 0, Page_UIListLayout.AbsoluteContentSize.Y + 50)

				local Button = Instance.new("Frame")
				local TextLabel = Instance.new("TextLabel")
				local ImageButton = Instance.new("ImageButton")
				local Button_UIStroke = Instance.new("UIStroke")

				Button.Name = "Button"
				Button.Parent = Page
				Button.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Position = UDim2.new(0, 0, 0.0919978395, 0)
				Button.Size = UDim2.new(0, 154, 0, 40)

				TextLabel.Parent = Button
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0.0382513665, 0, 0.25, 0)
				TextLabel.Size = UDim2.new(0.928961754, 0, 0.524999976, 0)
				TextLabel.Font = Enum.Font.Gotham
				TextLabel.Text = Name
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextScaled = true
				TextLabel.TextSize = 14.000
				TextLabel.TextWrapped = true

				ImageButton.Parent = Button
				ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageButton.BackgroundTransparency = 1.000
				ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageButton.BorderSizePixel = 0
				ImageButton.Size = UDim2.new(1, 0, 1, 0)
				ImageButton.ImageTransparency = 1.000

				Button_UIStroke.Name = "Button_UIStroke"
				Button_UIStroke.Parent = Button
				Button_UIStroke.Color = Color3.fromRGB(197, 197, 197)
				Button_UIStroke.Thickness = 1.5
				Button_UIStroke.Transparency = 1
				Button_UIStroke.Enabled = true
				Button_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter

				ImageButton.MouseEnter:Connect(function()
					TweenService:Create(Button_UIStroke, TweenInfo.new(0.1), {Transparency = 0}):Play()
				end)
				ImageButton.MouseLeave:Connect(function()
					TweenService:Create(Button_UIStroke, TweenInfo.new(0.1), {Transparency = 1}):Play()
				end)
				ImageButton.Activated:Connect(function()
					Function()
				end)

				Page.CanvasSize = UDim2.new(0, 0, 0, Page_UIListLayout.AbsoluteContentSize.Y + 50)

				return Button
			end

			function xSection:Toggle(Name, Function): Frame
				assert(typeof(Name) == "string", "Expected String, got ".. tostring(typeof(Name)))
				assert(typeof(Function) == "function", "Expected Function, got ".. tostring(typeof(Function)))

				local Toggle = Instance.new("Frame")
				local Toggle_Label = Instance.new("TextLabel")
				local ToggleFolder = Instance.new("Folder")
				local ActualToggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ToggleKnob = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local ImageButton = Instance.new("ImageButton")
				local UIListLayout = Instance.new("UIListLayout")
				local UIStroke = Instance.new("UIStroke")

				Toggle.Name = "Toggle"
				Toggle.Parent = Page
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.BackgroundTransparency = 1.000
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(9.1982578e-08, 0, 0.237975568, 0)
				Toggle.Size = UDim2.new(0, 244, 0, 30)

				Toggle_Label.Name = "Toggle_Label"
				Toggle_Label.Parent = Toggle
				Toggle_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle_Label.BackgroundTransparency = 1.000
				Toggle_Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle_Label.BorderSizePixel = 0
				Toggle_Label.Position = UDim2.new(0, 0, 0.0738098174, 0)
				Toggle_Label.Size = UDim2.new(0, 170, 0, 24)
				Toggle_Label.Font = Enum.Font.Gotham
				Toggle_Label.Text = Name
				Toggle_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
				Toggle_Label.TextScaled = true
				Toggle_Label.TextWrapped = true
				Toggle_Label.TextXAlignment = Enum.TextXAlignment.Left

				ToggleFolder.Name = "ToggleFolder"
				ToggleFolder.Parent = Toggle

				ActualToggle.Name = "ActualToggle"
				ActualToggle.Parent = ToggleFolder
				ActualToggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
				ActualToggle.BackgroundTransparency = 1.000
				ActualToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ActualToggle.BorderSizePixel = 0
				ActualToggle.Position = UDim2.new(0.793939412, 0, 0.0714285746, 0)
				ActualToggle.Size = UDim2.new(0, 52, 0, 20)

				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = ActualToggle

				ToggleKnob.Name = "ToggleKnob"
				ToggleKnob.Parent = ActualToggle
				ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleKnob.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleKnob.BorderSizePixel = 0
				ToggleKnob.Position = UDim2.new(0, 4, 0, 3)
				ToggleKnob.Size = UDim2.new(0, 14, 0, 14)

				UICorner_2.CornerRadius = UDim.new(1, 0)
				UICorner_2.Parent = ToggleKnob

				ImageButton.Parent = ActualToggle
				ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageButton.BackgroundTransparency = 1.000
				ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageButton.BorderSizePixel = 0
				ImageButton.Size = UDim2.new(1, 0, 1, 0)
				ImageButton.ImageTransparency = 1.000

				UIListLayout.Parent = ToggleFolder
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 2)

				UIStroke.Name = "UIStroke"
				UIStroke.Parent = ActualToggle
				UIStroke.Color = Color3.fromRGB(255, 255, 255)
				UIStroke.Thickness = 1.6
				UIStroke.Transparency = 0
				UIStroke.Enabled = true
				UIStroke.LineJoinMode = Enum.LineJoinMode.Round

				local ToggleEnabled = false

				ImageButton.Activated:Connect(function()
					ToggleEnabled = not ToggleEnabled

					if ToggleEnabled then
						TweenService:Create(ToggleKnob, TweenInfo.new(0.1), {Position = UDim2.fromOffset(34, 3)}):Play()
						TweenService:Create(ActualToggle, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
						UIStroke.Color = Color3.fromRGB(50, 50, 50)
					else
						TweenService:Create(ToggleKnob, TweenInfo.new(0.1), {Position = UDim2.fromOffset(4, 3)}):Play()
						TweenService:Create(ActualToggle, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
						UIStroke.Color = Color3.fromRGB(255, 255, 255)
					end

					Function(ToggleEnabled)
				end)

				Page.CanvasSize = UDim2.new(0, 0, 0, Page_UIListLayout.AbsoluteContentSize.Y + 50)

				return Toggle
			end

			function xSection:Dropdown(Name, Options, Function): Frame
				assert(typeof(Name) == "string", "Expected String, got ".. tostring(typeof(Name)))
				assert(typeof(Options) == "table", "Expected Table, got ".. tostring(typeof(Options)))
				assert(typeof(Function) == "function", "Expected Function, got ".. tostring(typeof(Function)))

				local xDropdown = {}
				local Dropdown = Instance.new("Frame")
				local DropName = Instance.new("TextLabel")
				local ActualDropdown = Instance.new("Frame")
				local Labels = Instance.new("Folder")
				local ImageLabel = Instance.new("ImageLabel")
				local UIListLayout = Instance.new("UIListLayout")
				local CurrentDropdown = Instance.new("TextLabel")
				local DropdownButton = Instance.new("ImageButton")
				local DropdownList = Instance.new("ScrollingFrame")
				local DropdownList_UIListLayout = Instance.new("UIListLayout")
				local UIStroke = Instance.new("UIStroke")

				--Properties:

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Page
				Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Dropdown.BackgroundTransparency = 1.000
				Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown.BorderSizePixel = 0
				Dropdown.Position = UDim2.new(9.1982578e-08, 0, 0.349795431, 0)
				Dropdown.Size = UDim2.new(0, 244, 0, 60)
				Dropdown.ZIndex = 5

				DropName.Name = "DropName"
				DropName.Parent = Dropdown
				DropName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropName.BackgroundTransparency = 1.000
				DropName.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DropName.BorderSizePixel = 0
				DropName.Position = UDim2.new(0, 0, 0.0545455925, 0)
				DropName.Size = UDim2.new(1, 0, 0.329166681, 0)
				DropName.Font = Enum.Font.Gotham
				DropName.Text = Name
				DropName.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropName.TextScaled = true
				DropName.TextSize = 14.000
				DropName.TextWrapped = true
				DropName.TextXAlignment = Enum.TextXAlignment.Left

				ActualDropdown.Name = "ActualDropdown"
				ActualDropdown.Parent = Dropdown
				ActualDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ActualDropdown.BackgroundTransparency = 1.000
				ActualDropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ActualDropdown.BorderSizePixel = 0
				ActualDropdown.Position = UDim2.new(0, 0, 0.554050148, 0)
				ActualDropdown.Size = UDim2.new(1, 0, 0.445949852, 0)

				Labels.Name = "Labels"
				Labels.Parent = ActualDropdown

				ImageLabel.Parent = Labels
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1.000
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Position = UDim2.new(0.854303181, 0, 0, 0)
				ImageLabel.Size = UDim2.new(0, 26, 0, 26)
				ImageLabel.Image = "rbxassetid://878102417"
				ImageLabel.ImageColor3 = Color3.fromRGB(185, 185, 185)

				UIListLayout.Parent = Labels
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 2)

				CurrentDropdown.Name = "CurrentDropdown"
				CurrentDropdown.Parent = ActualDropdown
				CurrentDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				CurrentDropdown.BackgroundTransparency = 1.000
				CurrentDropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				CurrentDropdown.BorderSizePixel = 0
				CurrentDropdown.Position = UDim2.new(0.0204919279, 0, 0.12626642, 0)
				CurrentDropdown.Size = UDim2.new(0.853320241, 0, 0.747467816, 0)
				CurrentDropdown.Font = Enum.Font.Gotham
				CurrentDropdown.Text = ""
				CurrentDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
				CurrentDropdown.TextScaled = true
				CurrentDropdown.TextSize = 14.000
				CurrentDropdown.TextWrapped = true
				CurrentDropdown.TextXAlignment = Enum.TextXAlignment.Left

				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = ActualDropdown
				DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownButton.BackgroundTransparency = 1.000
				DropdownButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DropdownButton.BorderSizePixel = 0
				DropdownButton.Size = UDim2.new(1, 0, 1, 0)
				DropdownButton.AutoButtonColor = false
				DropdownButton.ImageTransparency = 1.000

				DropdownList.Name = "DropdownList"
				DropdownList.Parent = Dropdown
				DropdownList.Active = true
				DropdownList.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
				DropdownList.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DropdownList.BorderSizePixel = 0
				DropdownList.Position = UDim2.new(0, 0, 0, 0)
				DropdownList.Size = UDim2.new(1, 0, 0, 0)
				DropdownList.CanvasSize = UDim2.new(0, 0, 0, 25)
				DropdownList.ScrollBarThickness = 3
				DropdownList.Visible = false

				DropdownList_UIListLayout.Name = "DropdownList_UIListLayout"
				DropdownList_UIListLayout.Parent = DropdownList
				DropdownList_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DropdownList_UIListLayout.Padding = UDim.new(0, 2)

				UIStroke.Name = "Button_UIStroke"
				UIStroke.Parent = ActualDropdown
				UIStroke.Color = Color3.fromRGB(225, 225, 225)
				UIStroke.Thickness = 1.8
				UIStroke.Enabled = true
				UIStroke.LineJoinMode = Enum.LineJoinMode.Miter

				DropdownButton.Activated:Connect(function()
					if DropdownList.Size.Y.Offset == 0 then return end
					
					DropdownList.Visible = not DropdownList.Visible
				end)

				function xDropdown:UpdateDropdown()
					for i, existingOption in DropdownList:GetChildren() do
						if string.match(existingOption.Name, "_Option") then
							existingOption:Destroy()
						end
					end
					
					for i, option in Options do
						local Option = Instance.new("TextButton")
						local TextLabel = Instance.new("TextLabel")

						Option.Name = tostring(option).. "_Option"
						Option.Parent = DropdownList
						Option.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
						Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Option.BorderSizePixel = 0
						Option.Size = UDim2.new(0, 244, 0, 26)
						Option.Font = Enum.Font.SourceSans
						Option.Text = ""
						Option.TextColor3 = Color3.fromRGB(34, 34, 34)
						Option.TextSize = 14.000

						TextLabel.Parent = Option
						TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						TextLabel.BackgroundTransparency = 1.000
						TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextLabel.BorderSizePixel = 0
						TextLabel.Position = UDim2.new(0.0315281712, 0, 0, 0)
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.Font = Enum.Font.Gotham
						TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextLabel.TextScaled = true
						TextLabel.TextSize = 14.000
						TextLabel.TextWrapped = true
						TextLabel.TextXAlignment = Enum.TextXAlignment.Left
						TextLabel.Text = option

						Option.Activated:Connect(function()
							DropdownList.Visible = false
							CurrentDropdown.Text = option

							Function(option)
						end)
					end
					
					DropdownList.Size = UDim2.new(DropdownList.Size.X.Scale, 0, 0, math.clamp(DropdownList_UIListLayout.AbsoluteContentSize.Y, 0, 82))
					DropdownList.CanvasSize = UDim2.new(0, 0, 0, DropdownList_UIListLayout.AbsoluteContentSize.Y)
					DropdownList.Position = UDim2.new(0, 0, 0, math.round(DropdownList.Size.Y.Offset / 10))
				end
				
				xDropdown:UpdateDropdown()

				Page.CanvasSize = UDim2.new(0, 0, 0, Page_UIListLayout.AbsoluteContentSize.Y + 50)

				return xDropdown
			end

			function xSection:Slider(Name, Icon, Min, Max, Function)
				assert(typeof(Name) == "string", "Expected String, got ".. tostring(typeof(Name)))
				assert(typeof(Icon) == "string", "Expected String, got ".. tostring(typeof(Icon)))
				assert(typeof(Min) == "number", "Expected Number, got ".. tostring(typeof(Min)))
				assert(typeof(Max) == "number", "Expected Number, got ".. tostring(typeof(Max)))
				assert(typeof(Function) == "function", "Expected Function, got ".. tostring(typeof(Function)))

				local Value = Min

				local xSlider = {}
				local Slider = Instance.new("Frame")
				local SliderLabel = Instance.new("TextLabel")
				local SliderIcon = Instance.new("ImageLabel")
				local ActualSlider = Instance.new("Frame")
				local Knob = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local KnobButton = Instance.new("ImageButton")
				local SliderValue = Instance.new("TextBox")

				Slider.Name = "Slider"
				Slider.Parent = Page
				Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider.BackgroundTransparency = 1.000
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Position = UDim2.new(-1.83965156e-07, 0, 0.547630548, 0)
				Slider.Size = UDim2.new(0, 258, 0, 60)

				SliderLabel.Name = "SliderLabel"
				SliderLabel.Parent = Slider
				SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderLabel.BackgroundTransparency = 1.000
				SliderLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderLabel.BorderSizePixel = 0
				SliderLabel.Position = UDim2.new(0, 0, 0.0545454547, 0)
				SliderLabel.Size = UDim2.new(1, 0, 0.379166663, 0)
				SliderLabel.Font = Enum.Font.Gotham
				SliderLabel.Text = Name
				SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderLabel.TextScaled = true
				SliderLabel.TextSize = 14.000
				SliderLabel.TextWrapped = true
				SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

				SliderIcon.Name = "SliderIcon"
				SliderIcon.Parent = Slider
				SliderIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderIcon.BackgroundTransparency = 1.000
				SliderIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderIcon.BorderSizePixel = 0
				SliderIcon.Position = UDim2.new(0, 0, 0.506438673, 0)
				SliderIcon.Size = UDim2.new(0, 25, 0, 25)
				SliderIcon.Image = "rbxassetid://".. Icon

				ActualSlider.Name = "ActualSlider"
				ActualSlider.Parent = Slider
				ActualSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				ActualSlider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ActualSlider.BorderSizePixel = 0
				ActualSlider.Position = UDim2.new(0.186746985, 0, 0.690909088, 0)
				ActualSlider.Size = UDim2.new(0.813252985, 0, 0, 3)

				Knob.Name = "Knob"
				Knob.Parent = ActualSlider
				Knob.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				Knob.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Knob.BorderSizePixel = 0
				Knob.Position = UDim2.new(0, 0, -3.8666687, 0)
				Knob.Size = UDim2.new(0, 8, 0, 26)

				UICorner.Parent = Knob

				KnobButton.Name = "KnobButton"
				KnobButton.Parent = ActualSlider
				KnobButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				KnobButton.BackgroundTransparency = 1.000
				KnobButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				KnobButton.BorderSizePixel = 0
				KnobButton.Position = UDim2.new(0, 0, -3.394, 0)
				KnobButton.Size = UDim2.new(1, 0, 8.194, 0)
				KnobButton.ImageTransparency = 1.000

				SliderValue.Name = "SliderValue"
				SliderValue.Parent = Slider
				SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderValue.BackgroundTransparency = 1.000
				SliderValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderValue.BorderSizePixel = 0
				SliderValue.Position = UDim2.new(1.003, 0, 0.521, 0)
				SliderValue.Size = UDim2.new(0.282, 0, 0.379, 0)
				SliderValue.ClearTextOnFocus = false
				SliderValue.Font = Enum.Font.Gotham
				SliderValue.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				SliderValue.PlaceholderText = Min.. ":".. Max
				SliderValue.Text = tonumber(Value)
				SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderValue.TextScaled = true
				SliderValue.TextSize = 14.000
				SliderValue.TextWrapped = true

				local Mouse = Players.LocalPlayer:GetMouse()
				local Move

				function xSlider:UpdateSlider()
					local Percentage = math.clamp((Mouse.X - ActualSlider.AbsolutePosition.X) / ActualSlider.AbsoluteSize.X, 0, 1)
					local Pos = UDim2.new(Percentage, 0, Knob.Position.Y.Scale, 0)
					Value = math.floor(((Pos.X.Scale * Max) / Max) * (Max - Min) + Min)
					Knob.Position = Pos
					SliderValue.Text = Value
					SliderValue.Text = SliderValue.Text:gsub("%D","")
				end

				KnobButton.MouseButton1Down:Connect(function()
					Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					xSlider:UpdateSlider()
					Function(tonumber(Value))
					Move = Mouse.Move:Connect(function()
						xSlider:UpdateSlider()
						Function(Value)
					end)
					UserInputService.InputEnded:Once(function()
						Knob.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
						Move:Disconnect()
						Move = nil
					end)
				end)
				SliderValue.FocusLost:Connect(function(enterPressed)
					if SliderValue.Text ~= "" then
						SliderValue.Text = SliderValue.Text:gsub("%D","")
					else
						SliderValue.Text = 0
					end
					
					if tonumber(SliderValue.Text) < Min then
						SliderValue.Text = Min
					elseif tonumber(SliderValue.Text) > Max then
						SliderValue.Text = Max
					end
					
					local Pos = UDim2.new((tonumber(SliderValue.Text) or 0) / Max, 0, Knob.Position.Y.Scale, 0)
					Knob.Position = Pos
					Function(tonumber(SliderValue.Text) or 0)
				end)

				Page.CanvasSize = UDim2.new(0, 0, 0, Page_UIListLayout.AbsoluteContentSize.Y + 50)

				return xSlider
			end

			Page.CanvasSize = UDim2.new(0, 0, 0, Page_UIListLayout.AbsoluteContentSize.Y + 50)

			return xSection
		end

		if not alreadyOnDefaultPage then
			alreadyOnDefaultPage = true

			Title.Text = Name
			Title.Visible = true
			for _, ExistingPage in Pages:GetChildren() do
				if string.match(ExistingPage.Name, "_Page") then
					ExistingPage.Visible = false
				end
			end
			for _, ExistingSelection in Tabs:GetDescendants() do
				if ExistingSelection:IsA("Frame") and ExistingSelection.Name == "Tab_Selected" then
					ExistingSelection.BackgroundTransparency = 1
				end
			end
			Tab_Selected.BackgroundTransparency = 0
			Page.Visible = true
		end

		Tabs.CanvasSize = UDim2.new(0, 0, 0, Tabs_UIListLayout.AbsoluteContentSize.Y)
		Page.CanvasSize = UDim2.new(0, 0, 0, Page_UIListLayout.AbsoluteContentSize.Y + 50)

		return xTab
	end

	local min, max, final = ("A"):byte(), ("z"):byte(), ""

	for i = 1, 20 do
		final ..= string.char(math.random(min, max))
	end

	BLOXUI.Name = final

	warn("Library Window Created!")

	Library:Drag(Window)

	UserInputService.InputBegan:Connect(function(Input, Proc)
		if Proc then return end

		if Input.KeyCode == Enum.KeyCode.LeftControl then
			Window.Visible = not Window.Visible
		end
	end)

	Close.Activated:Connect(function()
		Window.Visible = false

		Library:Notification({
			["Title"] = "UI Hidden",
			["Description"] = "Press ".. Enum.KeyCode.LeftControl.Name.. " to toggle Window Visibility"
		})
	end)

	local SearchInput = nil
	SearchBox.Focused:Connect(function()
		SearchInput = SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			print("Typed!")

			for _, Tab in Tabs:GetChildren() do
				if Tab:IsA("ImageButton") then
					Tab.Visible = string.find(string.lower(Tab["Tab_Name"].Text), string.lower(SearchBox.Text), 1, true) and true or false
					Tabs.CanvasSize = UDim2.new(0, 0, 0, Tabs_UIListLayout.AbsoluteContentSize.Y)
				end
			end
		end)
	end)
	SearchBox.FocusLost:Connect(function()
		if SearchInput ~= nil then
			SearchInput:Disconnect()
			SearchInput = nil
		end

		if SearchBox.Text == "" then
			for _, Tab in Tabs:GetChildren() do
				if Tab:IsA("ImageButton") then
					Tab.Visible = true
				end
			end
		end
	end)

	return xWindow
end

return Library
