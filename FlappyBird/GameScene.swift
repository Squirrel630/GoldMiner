//
//  GameScene.swift
//  FlappyBird
//
//  Created by Nate squirrel on 20/6/17.
//  Copyright (c) 2017 Fullstack.io. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    let verticalPipeGap = 150.0
    
    var hook:SKSpriteNode!
    var backgroud:SKSpriteNode!
    var bird:SKSpriteNode!
    var skyColor:SKColor!
    var pipeTextureUp:SKTexture!
    var pipeTextureDown:SKTexture!
    var movePipesAndRemove:SKAction!
    var movehook:SKAction!
    var moving:SKNode!
    var pipes:SKNode!
    var canRestart = Bool()
    
    var timeLabelNode :SKLabelNode!
    
    var scoreLabelNode:SKLabelNode!
    var score = NSInteger()
    var startDate = NSDate()
    var startTime=0
    var myTime=0
    
    var time1=0
    var time2=0
    
    let hookCategory: UInt32 = 1 << 1
    let goldCategory: UInt32 = 1 << 2
    let stoneCategory: UInt32 = 1 << 3
    let bagCategory: UInt32 = 1 << 4
 
    //主界面构造
    func createScene(){
        //改变背景颜色
        self.backgroundColor = SKColor.white
        physicsWorld.contactDelegate = self
        
        //设置游戏背景
        let background = SKSpriteNode(imageNamed: "bg")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(background)
        
        //添加顶部显示内容
        let moneyLabel=SKLabelNode(fontNamed:"Chalkduster")
        moneyLabel.text="Money:"
        moneyLabel.fontSize=17
        moneyLabel.position=CGPoint(x:self.frame.midX-170,y:self.frame.maxY-55)
        moneyLabel.isHidden=false
        self.addChild(moneyLabel)
        
        let goalLabel=SKLabelNode(fontNamed:"Chalkduster")
        goalLabel.text="Goal: 6666 "
        goalLabel.fontSize=17
        goalLabel.position=CGPoint(x:self.frame.midX-150,y:self.frame.maxY-87)
        goalLabel.isHidden=false
        self.addChild(goalLabel)
        
        let timeLabel=SKLabelNode(fontNamed:"Chalkduster")
        timeLabel.text="Time:"
        timeLabel.fontSize=17
        timeLabel.position=CGPoint(x:self.frame.midX+130,y:self.frame.maxY-55)
        timeLabel.isHidden=false
        self.addChild(timeLabel)
        
        let levelLabel=SKLabelNode(fontNamed:"Chalkduster")
        levelLabel.text="Level: 0"
        levelLabel.fontSize=17
        levelLabel.position=CGPoint(x:self.frame.midX+140,y:self.frame.maxY-87)
        levelLabel.isHidden=false
        self.addChild(levelLabel)

    }
    //添加金块
    func creategold(){
        let goldtexture = SKTexture(imageNamed: "gold")
        
        let gold1 = SKSpriteNode(texture: goldtexture)
        gold1.setScale(1)
        gold1.position = CGPoint(x: self.frame.midX+20, y: self.frame.midY+20)
        
        gold1.physicsBody?.usesPreciseCollisionDetection = true
        gold1.physicsBody = SKPhysicsBody(rectangleOf:gold1.size)
        gold1.physicsBody?.categoryBitMask = goldCategory
        gold1.physicsBody?.collisionBitMask = 0
        gold1.physicsBody?.contactTestBitMask = goldCategory
        gold1.isHidden=false
        addChild(gold1)
        
        let gold2 = SKSpriteNode(texture: goldtexture)
        gold2.setScale(2)
        gold2.position = CGPoint(x: self.frame.midX+130, y: self.frame.midY-200)
        
        gold2.physicsBody?.usesPreciseCollisionDetection = true
        gold2.physicsBody = SKPhysicsBody(rectangleOf:gold2.size)
        gold2.physicsBody?.categoryBitMask = goldCategory
        gold2.physicsBody?.collisionBitMask = 0
        gold2.physicsBody?.contactTestBitMask = goldCategory
        gold2.isHidden=false
        addChild(gold2)
        
        let gold3 = SKSpriteNode(texture: goldtexture)
        gold3.setScale(0.7)
        gold3.position = CGPoint(x: self.frame.midX-140, y: self.frame.midY+200)
        
        gold3.physicsBody?.usesPreciseCollisionDetection = true
        gold3.physicsBody = SKPhysicsBody(rectangleOf:gold3.size)
        gold3.physicsBody?.categoryBitMask = goldCategory
        gold3.physicsBody?.collisionBitMask = 0
        gold3.physicsBody?.contactTestBitMask = goldCategory
        gold3.isHidden=false
        addChild(gold3)
        
        let gold4 = SKSpriteNode(texture: goldtexture)
        gold4.setScale(1.3)
        gold4.position = CGPoint(x: self.frame.midX-110, y: self.frame.midY-100)
        
        gold4.physicsBody?.usesPreciseCollisionDetection = true
        gold4.physicsBody = SKPhysicsBody(rectangleOf:gold4.size)
        gold4.physicsBody?.categoryBitMask = goldCategory
        gold4.physicsBody?.collisionBitMask = 0
        gold4.physicsBody?.contactTestBitMask = goldCategory
        gold4.isHidden=false
        addChild(gold4)
        
        let gold5 = SKSpriteNode(texture: goldtexture)
        gold5.setScale(0.4)
        gold5.position = CGPoint(x: self.frame.midX+140, y: self.frame.midY+230)
        
        gold5.physicsBody?.usesPreciseCollisionDetection = true
        gold5.physicsBody = SKPhysicsBody(rectangleOf:gold5.size)
        gold5.physicsBody?.categoryBitMask = goldCategory
        gold5.physicsBody?.collisionBitMask = 0
        gold5.physicsBody?.contactTestBitMask = goldCategory
        gold5.isHidden=false
        addChild(gold5)
    }
    
    //添加石头
    func creatstone(){
        let stonetexture = SKTexture(imageNamed:"stone")
        let stone1=SKSpriteNode(texture:stonetexture)
        stone1.setScale(1)
        stone1.position = CGPoint(x: self.frame.midX+160, y: self.frame.midY+50)
        
        stone1.physicsBody?.usesPreciseCollisionDetection = true
        stone1.physicsBody = SKPhysicsBody(rectangleOf:stone1.size)
        stone1.physicsBody?.categoryBitMask = stoneCategory
        stone1.physicsBody?.collisionBitMask = 0
        stone1.physicsBody?.contactTestBitMask = stoneCategory
        stone1.isHidden=false
        addChild(stone1)
        
//        let stonetexture = SKTexture(imageNamed:"stone")
        let stone2=SKSpriteNode(texture:stonetexture)
        stone2.setScale(1.3)
        stone2.position = CGPoint(x: self.frame.midX-130, y: self.frame.midY+100)
        
        stone2.physicsBody?.usesPreciseCollisionDetection = true
        stone2.physicsBody = SKPhysicsBody(rectangleOf:stone2.size)
        stone2.physicsBody?.categoryBitMask = stoneCategory
        stone2.physicsBody?.collisionBitMask = 0
        stone2.physicsBody?.contactTestBitMask = stoneCategory
        stone2.isHidden=false
        addChild(stone2)
    
//        let stonetexture = SKTexture(imageNamed:"stone")
        let stone3=SKSpriteNode(texture:stonetexture)
        stone3.setScale(1.2)
        stone3.position = CGPoint(x: self.frame.midX+30, y: self.frame.midY-130)
        
        stone3.physicsBody?.usesPreciseCollisionDetection = true
        stone3.physicsBody = SKPhysicsBody(rectangleOf:stone3.size)
        stone3.physicsBody?.categoryBitMask = stoneCategory
        stone3.physicsBody?.collisionBitMask = 0
        stone3.physicsBody?.contactTestBitMask = stoneCategory
        stone3.isHidden=false
        addChild(stone3)
    
//        let stonetexture = SKTexture(imageNamed:"stone")
        let stone4=SKSpriteNode(texture:stonetexture)
        stone4.setScale(0.8)
        stone4.position = CGPoint(x: self.frame.midX+5, y: self.frame.midY+180)
        
        stone4.physicsBody?.usesPreciseCollisionDetection = true
        stone4.physicsBody = SKPhysicsBody(rectangleOf:stone4.size)
        stone4.physicsBody?.categoryBitMask = stoneCategory
        stone4.physicsBody?.collisionBitMask = 0
        stone4.physicsBody?.contactTestBitMask = stoneCategory
        stone4.isHidden=false
        addChild(stone4)
        
        let stone5=SKSpriteNode(texture:stonetexture)
        stone5.setScale(1)
        stone5.position = CGPoint(x: self.frame.midX-160, y: self.frame.midY-180)
        
        stone5.physicsBody?.usesPreciseCollisionDetection = true
        stone5.physicsBody = SKPhysicsBody(rectangleOf:stone5.size)
        stone5.physicsBody?.categoryBitMask = stoneCategory
        stone5.physicsBody?.collisionBitMask = 0
        stone5.physicsBody?.contactTestBitMask = stoneCategory
        stone5.isHidden=false
        addChild(stone5)
    }
    
    //添加福袋
    func creatbag(){
        let bagtexture=SKTexture(imageNamed:"bag")
        let bag1=SKSpriteNode(texture:bagtexture)
        bag1.setScale(1)
        bag1.position = CGPoint(x: self.frame.midX-20, y: self.frame.midY-250)
        
        
        bag1.physicsBody = SKPhysicsBody(rectangleOf:bag1.size)
        bag1.physicsBody?.categoryBitMask = bagCategory
        bag1.physicsBody?.collisionBitMask = 0
        bag1.physicsBody?.contactTestBitMask = bagCategory
        bag1.isHidden=false
        addChild(bag1)
    }
    
    func creathook(){
        //add hook
        let hookTexture = SKTexture(imageNamed: "hook")
        hookTexture.filteringMode = .nearest
        hook = SKSpriteNode(texture: hookTexture)
        hook.setScale(1.0)
        hook.position = CGPoint(x: self.frame.midX, y:self.frame.maxY-120)
        
        
        hook.physicsBody = SKPhysicsBody(circleOfRadius: hook.size.height / 2.0)
        hook.physicsBody?.isDynamic = true
        hook.physicsBody?.allowsRotation = false
        
        hook.physicsBody?.categoryBitMask = hookCategory
        hook.physicsBody?.collisionBitMask = goldCategory | stoneCategory
        hook.physicsBody?.contactTestBitMask = goldCategory | stoneCategory
//       
//        let MoveRight = SKAction.moveBy(x: 5, y: 0, duration: 0.5)
//        let hookMoveRight=SKAction.repeat(MoveRight, count: 40)
//        let MoveLeft = SKAction.moveBy(x: -5, y: 0, duration: 0.5)
//        let hookMoveLeft=SKAction.repeat(MoveLeft, count: 40)
      //  movehook=SKAction.sequence([hookMoveRight,hookMoveLeft,hookMoveLeft,hookMoveRight])

        let rotateRight = SKAction.rotate(byAngle: 0.015, duration: 0.03)
        let hookrotateRight=SKAction.repeat(rotateRight, count: 10)
        let rotateLeft = SKAction.rotate(byAngle: -0.015, duration: 0.03)
        let hookrotateLeft=SKAction.repeat(rotateLeft, count: 10)
        movehook=SKAction.sequence([hookrotateRight,hookrotateLeft,hookrotateLeft,hookrotateRight])
        hook.isHidden=false
        hook.run(SKAction.repeatForever(movehook))
       
//        var formatter =NSData.
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        var dateString = formatter.stringFromDate(nowDate)
//        println(dateString)
//        currentTime: TimeInterval
        let now = NSDate()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        time1 = Int(timeInterval)
//        time1=Int(currentTime)
        addChild(hook)
    //    self.startTime = Int(TimeInterval)
    }
    //判断碰撞
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == goldCategory | stoneCategory{
            print("bingo")
            
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
        }
    }
    
    override func didMove(to view: SKView) {
        //设置物理区域，重力为0
        physicsWorld.contactDelegate = self
        physicsWorld.gravity=CGVector( dx: 0.0, dy: 0.0 )
        
       // creathook()
        let hookTexture = SKTexture(imageNamed: "hook")
        hookTexture.filteringMode = .nearest
        hook = SKSpriteNode(texture: hookTexture)
        hook.setScale(1.0)
        hook.position = CGPoint(x: self.frame.midX, y:self.frame.maxY-120)
        
        
        hook.physicsBody = SKPhysicsBody(circleOfRadius: hook.size.height / 2.0)
        hook.physicsBody?.isDynamic = true
        hook.physicsBody?.allowsRotation = false
        
        hook.physicsBody?.categoryBitMask = hookCategory
        hook.physicsBody?.collisionBitMask = goldCategory | stoneCategory
        hook.physicsBody?.contactTestBitMask = goldCategory | stoneCategory
        
//        let MoveRight = SKAction.moveBy(x: 5, y: 0, duration: 0.5)
//        let hookMoveRight=SKAction.repeat(MoveRight, count: 40)
//        let MoveLeft = SKAction.moveBy(x: -5, y: 0, duration: 0.5)
//        let hookMoveLeft=SKAction.repeat(MoveLeft, count: 40)
//        movehook=SKAction.sequence([hookMoveRight,hookMoveLeft,hookMoveLeft,hookMoveRight])
//        hook.run(SKAction.repeatForever(movehook))
        let rotateRight = SKAction.rotate(byAngle: 0.03, duration: 0.05)
        let hookrotateRight=SKAction.repeat(rotateRight, count: 28)
        let rotateLeft = SKAction.rotate(byAngle: -0.03, duration: 0.05)
        let hookrotateLeft=SKAction.repeat(rotateLeft, count: 28)
        movehook=SKAction.sequence([hookrotateRight,hookrotateLeft,hookrotateLeft,hookrotateRight])
        hook.run(SKAction.repeatForever(movehook))
        hook.isHidden=false
        self.addChild(hook)
        moving = SKNode()
        self.addChild(moving)
        pipes = SKNode()
       
        canRestart = false
        
        // Initialize label and create a label which holds the score
        score = 0
        scoreLabelNode = SKLabelNode(fontNamed:"MarkerFelt-Wide")
        scoreLabelNode.position = CGPoint( x:self.frame.midX-120,y:self.frame.maxY-55)
        scoreLabelNode.zPosition = 100
        scoreLabelNode.fontColor=UIColor.green
        scoreLabelNode.fontSize=20
        scoreLabelNode.text = String(score)
        scoreLabelNode.isHidden=false
        self.addChild(scoreLabelNode)
        
        myTime=60
        timeLabelNode = SKLabelNode(fontNamed:"MarkerFelt-Wide")
        timeLabelNode.position = CGPoint(x:self.frame.midX+180,y:self.frame.maxY-55)
        timeLabelNode.color=UIColor.red
        timeLabelNode.fontColor=UIColor.red
        timeLabelNode.fontSize=19
        timeLabelNode.text = String(myTime)
        timeLabelNode.isHidden=false
        self.addChild(timeLabelNode)
        
    }
    
    func resetScene (){
        
        hook.position = CGPoint(x: self.frame.midX, y:self.frame.maxY-120)
      //  hook.zRotation = 0.0
        hook.physicsBody = SKPhysicsBody(circleOfRadius: hook.size.height / 2.0)
        hook.physicsBody?.isDynamic = true
        hook.physicsBody?.allowsRotation = false
        
        hook.physicsBody?.categoryBitMask = hookCategory
        hook.physicsBody?.collisionBitMask = goldCategory | stoneCategory
        hook.physicsBody?.contactTestBitMask = goldCategory | stoneCategory
        
      //  canRestart = false
        let rotateRight = SKAction.rotate(byAngle: 0.03, duration: 0.05)
        let hookrotateRight=SKAction.repeat(rotateRight, count: 28)
        let rotateLeft = SKAction.rotate(byAngle: -0.03, duration: 0.05)
        let hookrotateLeft=SKAction.repeat(rotateLeft, count: 28)
        movehook=SKAction.sequence([hookrotateRight,hookrotateLeft,hookrotateLeft,hookrotateRight])
        hook.run(SKAction.repeatForever(movehook))
        hook.isHidden=false
        self.addChild(hook)

        scoreLabelNode.text = String(score)
        timeLabelNode.text=String(myTime)
//        moving.speed = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     //   if moving.speed > 0  {
       //     for _ in touches { // do we need all touches?
               // movehook=SKAction.pause()
        let now = NSDate()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        time2 = Int(timeInterval)
        let temptime=Int(time2-time1)
        print(temptime)
//        temptime/29
        //let angle=Int(temptime/28)
        hook.removeAllActions()
        let hookMovedown=SKAction.moveBy(x:0, y: -5, duration: 1)
        movehook=SKAction.repeat(hookMovedown, count:20)
        hook.run(movehook)
         //   }
        //}else if canRestart {
         //   self.resetScene()
        //}

    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        createScene()
        creategold()
        creatstone()
        creatbag()
        startTime=Int(currentTime)
        myTime = 60-(Int(currentTime) - startTime)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == hookCategory | goldCategory{
           // print("enemy die")
            score=score+100
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            resetScene()
        }
       
        else if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == hookCategory | stoneCategory{
            // print("enemy die")
            score=score+50
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            resetScene()
        }
        
        else if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == hookCategory | bagCategory{
            // print("enemy die")
            score=score-50
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            resetScene()
        }

    }
}
