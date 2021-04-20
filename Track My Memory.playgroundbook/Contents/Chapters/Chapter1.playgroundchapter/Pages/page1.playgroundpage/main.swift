/*:
 # Fixed Partitioning
 
 This is the oldest and simplest technique, used to put more than one **[process](glossary://process)** in **[main memory](glossary://mainmemory)**.

 ## How does Fixed Partitioning work?
 
 In Fixed Partitioning, main memory can be divided either in parts of same size or from different sizes. The detail that makes both approaches equal is that the blocks which the main memory is divided are always from a fixed size.

## Strengths ✅:
 The algorithm is pretty simple and easy to implement. Furthermore, it requires little processing from the operating system.
 
## Weaknesses ❌:
 The number of blocks (or partitions) which the main memory is divided in this technique defines the exact number of processes that the operating system, through the memory, can execute at the same time. Also, if a process has a bigger size than the partition's, it won't run. Space that can possibly remain in a partition that has a process which size is smaller than the partition's size, can't be used by another process. We can call this case as Internal Fragmentation.
 
 # Let's play!
 
 In this game on the right, you are introduced to a four gigabyte sized main memory and five apps from different sizes. Since we're dealing with Fixed Partitioning, the memory was divided into five partitions of same sizes.
 
 - Callout(How to play):
 Click the "Run" button by the side of an app and see how the technique responds to your request! Also, try to run apps simultaneously to see the algorithm's behaviour.
 
 Simple, isn't it? 🤩
 
 - Note: Click on "Run My Code" when you're ready to start the game.

 */

//#-hidden-code
import PlaygroundSupport

PlaygroundPage.current.setLiveView(FixedPartitioningView())
//#-end-hidden-code
