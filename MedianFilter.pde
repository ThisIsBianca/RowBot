import java.util.PriorityQueue;
import java.util.Collections;
import java.util.LinkedList;

class MedianFilter {
    PriorityQueue<Float> minHeap;
    PriorityQueue<Float> maxHeap;
    LinkedList<Float> list;
    int size;
    
    public MedianFilter(int size){
      minHeap = new PriorityQueue<Float>();
      maxHeap = new PriorityQueue<Float>(10, Collections.reverseOrder());
      list = new LinkedList<Float>();
      this.size = size;
    }
      
    public float update(float num) {
      if(list.size() < size){
        addNum(num);
        list.addLast(num);
      }
      else{
        list.addLast(num);
        addNum(num);
        removeNum(list.removeFirst());
      }
      return findMedian();
    }
    
    
    
    private float findMedian() {
        if (maxHeap.size() == minHeap.size()) {
            return maxHeap.peek() / 2.0 + minHeap.peek() / 2.0; // be careful with Integer.MAX_VALUE, consider breaking or use long
        } else {
            return maxHeap.peek();
        }
    }
    
    private void addNum(float num) {
        if (maxHeap.isEmpty()) {
            maxHeap.add(num);
            return;
        }
        float currentMedian = maxHeap.peek();
        if (num <= currentMedian) {
            maxHeap.offer(num);
        } else {
            minHeap.offer(num);
        }
        balance();
    }
    
    private void removeNum(float num) {
        float currentMedian = maxHeap.peek();
        if (num <= currentMedian) {
            maxHeap.remove(num);
        } else {
            minHeap.remove(num);
        }
        balance();
    }
    
    // helper
    private void balance() {
        if (maxHeap.size() > minHeap.size() + 1) {
            minHeap.offer(maxHeap.poll());
        } else if (maxHeap.size() < minHeap.size()) {
            maxHeap.offer(minHeap.poll());
        }
    }
}
